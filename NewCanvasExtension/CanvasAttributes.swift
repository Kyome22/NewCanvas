//
//  CanvasAttributes.swift
//  NewCanvasExtension
//
//  Created by Takuto Nakamura on 2022/06/26.
//

import Cocoa

typealias FileFormat = NSBitmapImageRep.FileType

struct CanvasAttributes {
    let size: NSSize
    let fillColor: NSColor
    let fileFormat: FileFormat
}
