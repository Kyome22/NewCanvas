//
//  FileManager+Extension.swift
//  NewCanvasExtension
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import Foundation

extension FileManager {
    static var homeDirectoryURL: URL? {
        guard let pw = getpwuid(getuid()), let home = pw.pointee.pw_dir else { return nil }
        let homePath = self.default.string(withFileSystemRepresentation: home,
                                           length: strlen(home))
        return URL(fileURLWithPath: homePath)
    }
}
