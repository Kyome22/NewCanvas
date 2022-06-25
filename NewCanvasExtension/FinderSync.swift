//
//  FinderSync.swift
//  NewCanvasExtension
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import Cocoa
import FinderSync
import UniformTypeIdentifiers
import SwiftUI

final class FinderSync: FIFinderSync {
    private let MAIN_APP_ID = "com.kyome.NewCanvas"

    override init() {
        super.init()

        if let homeDirectoryURL = FileManager.homeDirectoryURL {
            FIFinderSyncController.default().directoryURLs = [homeDirectoryURL]
        }
    }

    override var toolbarItemName: String {
        return "NewCanvas"
    }

    override var toolbarItemToolTip: String {
        return "performTasks".localized
    }

    override var toolbarItemImage: NSImage {
        return NSImage(named: "toolbarIcon")!
    }

    override func menu(for menuKind: FIMenuKind) -> NSMenu? {
        guard menuKind == .contextualMenuForContainer || menuKind == .toolbarItemMenu else {
            return nil
        }
        let menuItem = NSMenuItem(title: "openNewCanvas".localized,
                                  action: #selector(newCanvas(_:)),
                                  keyEquivalent: "")
        if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: MAIN_APP_ID) {
            menuItem.image = NSWorkspace.shared.icon(forFile: url.path)
        }
        let newMenu = NSMenu(title: "")
        newMenu.addItem(menuItem)
        return newMenu
    }

    @objc func newCanvas(_ sender: Any?) {
        guard let target = FIFinderSyncController.default().targetedURL() else {
            return
        }
        NSApp.activate(ignoringOtherApps: true)
        DispatchQueue.main.async {
            let panel = NSSavePanel()
            panel.directoryURL = target
            panel.canCreateDirectories = true
            panel.allowedContentTypes = [.png]
            panel.showsTagField = false
            panel.title = "newCanvas".localized
            panel.message = "createCanvas".localized
            panel.level = .popUpMenu
            panel.prompt = "saveOpen".localized
            let accessoryViewModel = AccessoryViewModel { fileType in
                panel.allowedContentTypes = [fileType]
            }
            let hostingView = NSHostingView(rootView: AccessoryView(viewModel: accessoryViewModel))
            hostingView.setFrameSize(NSSize(width: 200, height: 150))
            panel.accessoryView = hostingView
            if panel.runModal() == .OK, let url = panel.url {
                self.createCanvas(url: url, attributes: accessoryViewModel.attributes)
            }
        }
    }

    private func createCanvas(url: URL, attributes: CanvasAttributes) {
        let image = NSImage(size: attributes.size)
        image.lockFocus()
        let rect = NSRect(origin: .zero, size: attributes.size)
        attributes.fillColor.drawSwatch(in: rect)
        image.unlockFocus()
        guard let rep = image.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: rep),
              let data = bitmap.representation(using: attributes.fileFormat, properties: [:])
        else {
            return
        }
        do {
            try data.write(to: url)
            let workspace = NSWorkspace.shared
            if let appURL = workspace.urlForApplication(withBundleIdentifier: "com.apple.Preview") {
                let config = NSWorkspace.OpenConfiguration()
                workspace.open([url], withApplicationAt: appURL, configuration: config)
            }
        } catch {
            #if DEBUG
            NSLog("🐤 %@", error.localizedDescription)
            #endif
        }
    }
}
