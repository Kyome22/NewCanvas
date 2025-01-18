/*
 CGContextClient.swift
 DataLayer

 Created by Takuto Nakamura on 2025/01/18.
 
*/

import CoreGraphics

public struct CGContextClient: DependencyClient {
    public var makeImage: @Sendable (CGContext) -> CGImage?

    public static let liveValue = Self(
        makeImage: { $0.makeImage() }
    )

    public static let testValue = Self(
        makeImage: { _ in nil }
    )
}
