/*
 ExportFile.swift
 DataLayer

 Created by Takuto Nakamura on 2024/11/09.
 
*/

import SwiftUI
import UniformTypeIdentifiers

public struct ExportFile: FileDocument {
    public static let readableContentTypes: [UTType] = FileFormat.supportedFormats.map(\.type)

    let generateHandler: @Sendable (UTType) throws -> Data

    public init(generateHandler: @escaping @Sendable (UTType) throws -> Data) {
        self.generateHandler = generateHandler
    }

    public init(configuration: ReadConfiguration) throws {
        fatalError()
    }

    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        try FileWrapper(regularFileWithContents: generateHandler(configuration.contentType))
    }
}
