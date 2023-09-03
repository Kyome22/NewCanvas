//
//  SettingsView.swift
//  NewCanvas
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("general", systemImage: "gear")
                }
            AboutView()
                .tabItem {
                    Label("about", systemImage: "info.circle")
                }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
