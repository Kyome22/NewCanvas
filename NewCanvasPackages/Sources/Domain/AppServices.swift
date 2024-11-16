/*
 AppServices.swift
 Domain

 Created by Takuto Nakamura on 2024/11/17.
 
*/

import DataLayer
import SwiftUI

public final class AppServices: Sendable {
    public let canvasService: CanvasService
    public let logService: LogService

    public nonisolated init(appDependencies: AppDependencies) {
        canvasService = .init(appDependencies.fileManagerClient)
        logService = .init(appDependencies.loggingSystemClient)
    }
}

struct AppServicesKey: EnvironmentKey {
    static let defaultValue = AppServices(appDependencies: AppDependenciesKey.defaultValue)
}

public extension EnvironmentValues {
    var appServices: AppServices {
        get { self[AppServicesKey.self] }
        set { self[AppServicesKey.self] = newValue }
    }
}
