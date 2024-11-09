/*
 FileFormat.swift
 DataLayer

 Created by Takuto Nakamura on 2024/11/07.
 
*/

import AppKit
import UniformTypeIdentifiers

public typealias FileFormat = NSBitmapImageRep.FileType

extension FileFormat {
    public static let supportedFormats: [FileFormat] = [.png, .jpeg, .gif, .tiff, .bmp]

    public init?(type: UTType) {
        switch type {
        case .tiff: self = .tiff
        case .bmp:  self = .bmp
        case .gif:  self = .gif
        case .jpeg: self = .jpeg
        case .png:  self = .png
        default:    return nil
        }
    }

    public var type: UTType {
        switch self {
        case .tiff: .tiff
        case .bmp:  .bmp
        case .gif:  .gif
        case .jpeg: .jpeg
        case .png:  .png
        default:    fatalError()
        }
    }
}
