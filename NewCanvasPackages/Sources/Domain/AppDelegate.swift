/*
 AppDelegate.swift
 Domain

 Created by Takuto Nakamura on 2024/11/07.

*/

import AppKit

public final class AppDelegate: NSObject, NSApplicationDelegate {
    public let appDependencies = AppDependencies()
    public let appServices: AppServices

    public override init() {
        appServices = .init(appDependencies: appDependencies)
        super.init()
    }

    public func applicationDidFinishLaunching(_ notification: Notification) {
        Task {
            await appServices.logService.bootstrap()
            appServices.logService.notice(.launchApp)
        }
        NSApp.servicesProvider = ServicesProvider.shared
        NSUpdateDynamicServices()
    }

    public func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
