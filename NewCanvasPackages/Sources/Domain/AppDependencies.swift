/*
 AppDependencies.swift
 Domain

 Created by Takuto Nakamura on 2024/11/07.
 
*/

import DataLayer
import SwiftUI

public final class AppDependencies: Sendable {
    public let cgContextClient: CGContextClient
    public let fileManagerClient: FileManagerClient
    public let loggingSystemClient: LoggingSystemClient
    public let nsWorkspaceClient: NSWorkspaceClient

    public nonisolated init(
        cgContextClient: CGContextClient = .liveValue,
        fileManagerClient: FileManagerClient = .liveValue,
        loggingSystemClient: LoggingSystemClient = .liveValue,
        nsWorkspaceClient: NSWorkspaceClient = .liveValue
    ) {
        self.cgContextClient = cgContextClient
        self.fileManagerClient = fileManagerClient
        self.loggingSystemClient = loggingSystemClient
        self.nsWorkspaceClient = nsWorkspaceClient
    }
}

struct AppDependenciesKey: EnvironmentKey {
    static let defaultValue = AppDependencies(
        cgContextClient: .testValue,
        fileManagerClient: .testValue,
        loggingSystemClient: .testValue,
        nsWorkspaceClient: .testValue
    )
}

public extension EnvironmentValues {
    var appDependencies: AppDependencies {
        get { self[AppDependenciesKey.self] }
        set { self[AppDependenciesKey.self] = newValue }
    }
}
