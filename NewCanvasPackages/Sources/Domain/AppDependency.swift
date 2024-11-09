/*
 AppDependency.swift
 Domain

 Created by Takuto Nakamura on 2024/11/07.
 
*/

import DataLayer
import Observation
import SwiftUI

public final class AppDependency: Sendable {
    public let canvasService: CanvasService
    public let logService: LogService

    public nonisolated init(
        fileManagerClient: FileManagerClient = .liveValue,
        loggingSystemClient: LoggingSystemClient = .liveValue,
        nsWorkspaceClient: NSWorkspaceClient = .liveValue
    ) {
        canvasService = .init(fileManagerClient, nsWorkspaceClient)
        logService = .init(loggingSystemClient)
    }
}

struct AppDependencyKey: EnvironmentKey {
    static let defaultValue = AppDependency(
        fileManagerClient: .testValue,
        loggingSystemClient: .testValue,
        nsWorkspaceClient: .testValue
    )
}

public extension EnvironmentValues {
    var appDependency: AppDependency {
        get { self[AppDependencyKey.self] }
        set { self[AppDependencyKey.self] = newValue }
    }
}
