//
//  FinderSync.swift
//  FinderSyncExtension
//
//  Created by Takuto Nakamura on 2021/06/25.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {
    
    override init() {
        super.init()
        
        if let homeDirURL = FileManager.homeDirectoryURL {
            FIFinderSyncController.default().directoryURLs = [homeDirURL]
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
        guard menuKind == .contextualMenuForContainer || menuKind == .toolbarItemMenu else { return nil }
        let menuItem = NSMenuItem(title: "openNewCanvas".localized,
                                  action: #selector(FinderSync.newCanvas(_:)),
                                  keyEquivalent: "")
        let id = "com.kyome.NewCanvas"
        if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: id) {
            menuItem.image = NSWorkspace.shared.icon(forFile: url.path)
        }
        let newMenu = NSMenu(title: "")
        newMenu.addItem(menuItem)
        return newMenu
    }
        
    @IBAction func newCanvas(_ sender: AnyObject?) {
        guard let target = FIFinderSyncController.default().targetedURL(),
              let accessoryView = createAccessoryView()
        else { return }
        NSApp.activate(ignoringOtherApps: true)
        DispatchQueue.main.async {
            let panel = NSSavePanel()
            panel.directoryURL = target
            panel.canCreateDirectories = true
            panel.allowedFileTypes = ["png"]
            panel.showsTagField = false
            panel.title = "newCanvas".localized
            panel.message = "createCanvas".localized
            panel.level = .popUpMenu
            panel.prompt = "saveOpen".localized
            accessoryView.changeFileFormatHandler = { format in
                panel.allowedFileTypes = [format]
            }
            panel.accessoryView = accessoryView
            panel.begin { (response) in
                if response == .OK, let url = panel.url {
                    guard let data = self.createCanvas(accessoryView.attributes) else { return }
                    do {
                        try data.write(to: url)
                        NSWorkspace.shared.openFile(url.path, withApplication: "Preview")
                    } catch {
                        NSLog("🐤 \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func createAccessoryView() -> AccessoryView? {
        var topLevelArray: NSArray? = nil
        guard let nib = NSNib(nibNamed: "AccessoryView", bundle: Bundle.main),
              nib.instantiate(withOwner: nil, topLevelObjects: &topLevelArray),
              let results = topLevelArray as? [Any],
              let item = results.last(where: { $0 is AccessoryView }),
              let accessoryView = item as? AccessoryView
        else { return nil }
        return accessoryView
    }

    private func createCanvas(_ attributes: Attributes) -> Data? {
        let (size, fillColor, fileFormat) = attributes
        let image = NSImage(size: size)
        image.lockFocus()
        fillColor.drawSwatch(in: NSRect(origin: .zero, size: size))
        image.unlockFocus()
        guard let rep = image.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: rep),
              let data = bitmap.representation(using: fileFormat, properties: [:])
        else { return nil }
        return data
    }

}
