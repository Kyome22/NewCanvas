//
//  Extensions.swift
//  FinderSyncExtension
//
//  Created by Takuto Nakamura on 2021/09/05.
//

import Cocoa

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}

extension NSTextField {
    open override func performKeyEquivalent(with event: NSEvent) -> Bool {
        let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        if flags == [.command] {
            let selector: Selector
            switch event.charactersIgnoringModifiers?.lowercased() {
            case "x": selector = #selector(NSText.cut(_:))
            case "c": selector = #selector(NSText.copy(_:))
            case "v": selector = #selector(NSText.paste(_:))
            case "a": selector = #selector(NSText.selectAll(_:))
            case "z": selector = Selector(("undo:"))
            default: return super.performKeyEquivalent(with: event)
            }
            return NSApp.sendAction(selector, to: nil, from: self)
        } else if flags == [.shift, .command] {
            if event.charactersIgnoringModifiers?.lowercased() == "z" {
                return NSApp.sendAction(Selector(("redo:")), to: nil, from: self)
            }
            self.undoManager?.undo()
        }
        return super.performKeyEquivalent(with: event)
    }
}

extension FileManager {
    static var homeDirectoryURL: URL? {
        guard let pw = getpwuid(getuid()), let home = pw.pointee.pw_dir else { return nil }
        let homePath = self.default.string(withFileSystemRepresentation: home,
                                           length: strlen(home))
        return URL(fileURLWithPath: homePath)
    }
}
