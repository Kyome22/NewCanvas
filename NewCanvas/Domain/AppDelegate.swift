//
//  AppDelegate.swift
//  NewCanvas
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        openSettings()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    private func openSettings() {
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
        NSApp.windows.forEach { window in
            if window.canBecomeMain {
                window.orderFrontRegardless()
                window.center()
                NSApp.activate(ignoringOtherApps: true)
            }
        }
    }
}
