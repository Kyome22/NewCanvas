//
//  GeneralSettingsViewModel.swift
//  NewCanvas
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import SwiftUI
import Combine
import FinderSync

final class GeneralSettingsViewModel: ObservableObject {
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

    @Published var extensionState: ExtensionState = .notAllowed
    private var cancellables = Set<AnyCancellable>()

    init() {
        NotificationCenter.default
            .publisher(for: NSApplication.didBecomeActiveNotification)
            .sink { [weak self] notification in
                self?.updateState()
            }
            .store(in: &cancellables)
    }

    func updateState() {
        if FIFinderSyncController.isExtensionEnabled {
            extensionState = .allowed
        } else {
            extensionState = .notAllowed
        }
    }

    func openSystemPreferences() {
        FIFinderSyncController.showExtensionManagementInterface()
    }
}
