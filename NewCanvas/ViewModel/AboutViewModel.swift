//
//  AboutViewModel.swift
//  NewCanvas
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import Foundation

final class AboutViewModel: ObservableObject {
    let version: String
    let copyright: String

    init() {
        let bundleShortVersion = "CFBundleShortVersionString".bundleString!
        version = "version".localized
            .replacingOccurrences(of: "SHORT_VERSION", with: bundleShortVersion)
        copyright = "NSHumanReadableCopyright".bundleString!
    }
}
