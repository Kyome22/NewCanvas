/*
 WorkspaceWindow.swift
 Presentation

 Created by Takuto Nakamura on 2024/11/09.
 
*/

import Domain
import SwiftUI

public struct WorkspaceWindow: Scene {
    @Environment(\.appDependencies) private var appDependencies
    @Environment(\.appServices) private var appServices

    public init() {}

    public var body: some Scene {
        Window(Text("appTitle", bundle: .module), id: "workspace") {
            WorkspaceView(
                nsWorkspaceClient: appDependencies.nsWorkspaceClient,
                canvasService: appServices.canvasService,
                logService: appServices.logService
            )
            .windowMinimizeDisabled()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .windowFloating()
        .defaultPosition(.center)
    }
}
