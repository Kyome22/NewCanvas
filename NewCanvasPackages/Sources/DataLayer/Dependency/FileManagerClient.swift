/*
 FileManagerClient.swift
 DataLayer

 Created by Takuto Nakamura on 2024/11/08.
 
*/

import Foundation

public struct FileManagerClient: DependencyClient {
    public var homeDirectoryForCurrentUser: @Sendable () -> URL

    public static let liveValue = Self(
        homeDirectoryForCurrentUser: { FileManager.default.homeDirectoryForCurrentUser }
    )

    public static let testValue = Self(
        homeDirectoryForCurrentUser: { URL(filePath: "/Users/test", directoryHint: .isDirectory) }
    )
}
