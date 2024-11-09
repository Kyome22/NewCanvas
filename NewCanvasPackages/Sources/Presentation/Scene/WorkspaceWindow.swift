/*
 WorkspaceWindow.swift
 Presentation

 Created by Takuto Nakamura on 2024/11/09.
 
*/

import Domain
import SwiftUI

public struct WorkspaceWindow: Scene {
    @Environment(\.appDependency) private var appDependency

    public init() {}

    public var body: some Scene {
        Window(Text("appTitle", bundle: .module), id: "workspace") {
            WorkspaceView(
                canvasService: appDependency.canvasService,
                logService: appDependency.logService
            )
            .windowMinimizeDisabled()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .windowFloating()
        .defaultPosition(.center)
    }
}
