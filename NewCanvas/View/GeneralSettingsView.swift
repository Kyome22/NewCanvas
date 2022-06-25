//
//  GeneralSettingsView.swift
//  NewCanvas
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import SwiftUI

struct GeneralSettingsView: View {
    @StateObject var viewModel = GeneralSettingsViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("requiresPermission")
                .font(.title2)
            Text("givePermission")
            Button {
                viewModel.openSystemPreferences()
            } label: {
                Text("openPreferences")
                    .frame(width: 280)
            }
            Label(viewModel.extensionState.label,
                  systemImage: viewModel.extensionState.systemImage)
            .padding(.top, 8)
        }
        .fixedSize()
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}
