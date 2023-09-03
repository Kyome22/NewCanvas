//
//  AboutView.swift
//  NewCanvas
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import SwiftUI

struct AboutView: View {
    @StateObject var viewModel = AboutViewModel()

    var body: some View {
        HStack(spacing: 20) {
            Image("Icon")
                .frame(width: 100, height: 100, alignment: .center)
            VStack(alignment: .leading, spacing: 8) {
                Text("NewCanvas")
                    .font(.largeTitle)
                Text(viewModel.version)
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                Spacer()
                Text(viewModel.copyright)
                    .font(.caption)
                    .foregroundColor(Color.secondary)
            }
            .frame(height: 100)
        }
        .fixedSize()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
