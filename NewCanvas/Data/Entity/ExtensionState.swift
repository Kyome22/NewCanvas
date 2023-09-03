//
//  ExtensionState.swift
//  NewCanvas
//
//  Created by ky0me22 on 2023/09/03.
//

import SwiftUI

enum ExtensionState {
    case notAllowed
    case allowed

    var label: LocalizedStringKey {
        switch self {
        case .notAllowed: return "extensionNotAllowed"
        case .allowed:    return "extensionAllowed"
        }
    }

    var systemImage: String {
        switch self {
        case .notAllowed: return "exclamationmark.triangle"
        case .allowed:    return "checkmark"
        }
    }
}
