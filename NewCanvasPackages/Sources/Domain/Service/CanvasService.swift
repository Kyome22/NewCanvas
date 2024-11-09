/*
 CanvasService.swift
 Domain

 Created by Takuto Nakamura on 2024/11/08.
 
*/

import AppKit
import DataLayer
import Foundation
import Logging
import UniformTypeIdentifiers

public actor CanvasService {
    private let fileManagerClient: FileManagerClient
    private let nsWorkspaceClient: NSWorkspaceClient

    nonisolated lazy var homeDirectory: URL = {
        fileManagerClient
            .homeDirectoryForCurrentUser()
            .pathComponents
            .prefix(3)
            .reduce {
                URL(filePath: $0)
            } successor: {
                $0.append(path: $1, directoryHint: .isDirectory)
            }
    }()

    public init(
        _ fileManagerClient: FileManagerClient,
        _ nsWorkspaceClient: NSWorkspaceClient
    ) {
        self.fileManagerClient = fileManagerClient
        self.nsWorkspaceClient = nsWorkspaceClient
    }

    public nonisolated func createCanvas(
        _ type: UTType,
        _ size: CGSize,
        _ fillColor: CGColor
    ) throws -> Data {
        guard let cgContext = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: 4 * Int(size.width),
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            throw CanvasError.failedToCreateCGContext
        }
        cgContext.interpolationQuality = .high
        cgContext.setFillColor(fillColor)
        cgContext.fill(CGRect(origin: .zero, size: size))
        guard let cgImage = cgContext.makeImage() else {
            throw CanvasError.failedToMakeImageFromCGContext
        }
        let bitmap = NSBitmapImageRep(cgImage: cgImage)
        guard let fileFormat = FileFormat(type: type),
              let data = bitmap.representation(using: fileFormat, properties: [:]) else {
            throw CanvasError.failedToConvertDataFromImageRep
        }
        return data
    }

    public nonisolated func openCanvas(url: URL) async throws {
        if let appURL = nsWorkspaceClient.urlForApplication("com.apple.Preview") {
            _ = try await nsWorkspaceClient.open([url], appURL)
        }
    }
}

public enum CanvasError: Error {
    case failedToCreateCGContext
    case failedToMakeImageFromCGContext
    case failedToConvertDataFromImageRep
}
