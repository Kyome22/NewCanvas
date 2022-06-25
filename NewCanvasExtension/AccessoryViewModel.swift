//
//  AccessoryViewModel.swift
//  NewCanvasExtension
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import AppKit
import Combine
import UniformTypeIdentifiers

final class AccessoryViewModel: ObservableObject {
    @Published var format: FileFormat = .png
    @Published var width: Int = 800
    @Published var height: Int = 450
    @Published var fillColor: CGColor = .white

    private var cancellable: AnyCancellable?

    init(didChangeFileFormat handler: @escaping (UTType) -> Void) {
        cancellable = $format.sink { fileFormat in
            switch fileFormat {
            case .tiff: handler(UTType.tiff)
            case .bmp:  handler(UTType.bmp)
            case .gif:  handler(UTType.gif)
            case .jpeg: handler(UTType.jpeg)
            case .png:  handler(UTType.png)
            default: break
            }
        }
    }

    var attributes: CanvasAttributes {
        return CanvasAttributes(
            size: NSSize(width: width, height: height),
            fillColor: NSColor(cgColor: fillColor) ?? .white,
            fileFormat: format
        )
    }
}
