/*
 WorkspaceViewModel.swift
 Domain

 Created by Takuto Nakamura on 2024/11/09.
 
*/

import CoreGraphics
import DataLayer
import Foundation
import Observation

@MainActor @Observable public final class WorkspaceViewModel {
    private let canvasService: CanvasService
    private let logService: LogService

    public var width: Int = 800
    public var height: Int = 450
    public var fillColor = CGColor.white
    public var isPresentedFileExporter = false
    public var directoryURL: URL

    public init(
        _ canvasService: CanvasService,
        _ logService: LogService
    ) {
        self.canvasService = canvasService
        self.logService = logService
        directoryURL = canvasService.homeDirectory
    }

    public func onAppear(screenName: String) {
        logService.notice(.screenView(name: screenName))
    }

    public func exportFile() -> ExportFile {
        let size = CGSize(width: width, height: height)
        let fillColor = fillColor
        return ExportFile { type in
            try self.canvasService.createCanvas(type, size, fillColor)
        }
    }

    public func onCompletionFileExporter(
        _ result: Result<URL, any Error>,
        closeWindow: @escaping () -> Void
    ) {
        switch result {
        case let .success(url):
            Task {
                try await canvasService.openCanvas(url: url)
                closeWindow()
            }
        case let .failure(error):
            logService.critical(.failedSaveFile(error))
        }
    }
}
