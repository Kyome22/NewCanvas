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

    func openSystemSettings() {
        FIFinderSyncController.showExtensionManagementInterface()
    }
}
