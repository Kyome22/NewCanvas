//
//  String+Extensions.swift
//  NewCanvas
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    var bundleString: String? {
        return Bundle.main.object(forInfoDictionaryKey: self) as? String
    }
}
