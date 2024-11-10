/*
 AppDelegate.swift
 Domain

 Created by Takuto Nakamura on 2024/11/07.

*/

import AppKit

public final class AppDelegate: NSObject, NSApplicationDelegate {
    public let appDependency = AppDependency()

    public func applicationDidFinishLaunching(_ notification: Notification) {
        Task {
            await appDependency.logService.bootstrap()
            appDependency.logService.notice(.launchApp)
        }
        NSApp.servicesProvider = ServicesProvider.shared
        NSUpdateDynamicServices()
    }

    public func applicationWillTerminate(_ notification: Notification) {}

    public func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
