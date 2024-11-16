/*
 NewCanvasApp.swift
 NewCanvas

 Created by Takuto Nakamura on 2022/06/25.
*/

import Domain
import Presentation
import SwiftUI

@main
struct NewCanvasApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WorkspaceWindow()
            .environment(\.appDependencies, appDelegate.appDependencies)
            .environment(\.appServices, appDelegate.appServices)
    }
}
