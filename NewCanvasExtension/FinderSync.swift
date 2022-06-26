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
                if let data = self.createCanvas(attributes: accessoryViewModel.attributes) {
                    self.saveAndOpenCanvas(url: url, data: data)
                }
            }
        }
    }

    private func createCanvas(attributes: CanvasAttributes) -> Data? {
        guard let cgContext = CGContext(data: nil,
                                        width: Int(attributes.size.width),
                                        height: Int(attributes.size.height),
                                        bitsPerComponent: 8,
                                        bytesPerRow: 4 * Int(attributes.size.width),
                                        space: CGColorSpaceCreateDeviceRGB(),
                                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else {
            return nil
        }
        cgContext.interpolationQuality = .high
        cgContext.setFillColor(attributes.fillColor)
        cgContext.fill(CGRect(origin: .zero, size: attributes.size))
        guard let cgImage = cgContext.makeImage() else {
            return nil
        }
        let bitmap = NSBitmapImageRep(cgImage: cgImage)
        return bitmap.representation(using: attributes.fileFormat, properties: [:])
    }

    private func saveAndOpenCanvas(url: URL, data: Data) {
        do {
            try data.write(to: url)
        } catch {
            #if DEBUG
            NSLog("🐤 %@", error.localizedDescription)
            #endif
        }
        // Open Preview
        let workspace = NSWorkspace.shared
        if let appURL = workspace.urlForApplication(withBundleIdentifier: "com.apple.Preview") {
            let config = NSWorkspace.OpenConfiguration()
            workspace.open([url], withApplicationAt: appURL, configuration: config)
        }
    }
}
