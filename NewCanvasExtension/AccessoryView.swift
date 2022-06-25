//
//  AccessoryView.swift
//  NewCanvasExtension
//
//  Created by Takuto Nakamura on 2022/06/25.
//

import SwiftUI

struct AccessoryView: View {
    @StateObject var viewModel: AccessoryViewModel

    init(viewModel: AccessoryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    private let formatter: Formatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                wrapText("format:")
                Picker(selection: $viewModel.format, label: EmptyView()) {
                    Text("TIFF").tag(FileFormat.tiff)
                    Text("BMP").tag(FileFormat.bmp)
                    Text("GIF").tag(FileFormat.gif)
                    Text("JPEG").tag(FileFormat.jpeg)
                    Text("PNG").tag(FileFormat.png)
                }
            }
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                wrapText("width:")
                Spacer(minLength: 8)
                TextField("800", value: $viewModel.width, formatter: formatter)
                Text("px")
            }
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                wrapText("height:")
                Spacer(minLength: 8)
                TextField("450", value: $viewModel.height, formatter: formatter)
                Text("px")
            }
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                wrapText("fillColor:")
                ColorPicker("", selection: $viewModel.fillColor)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func wrapText(_ key: LocalizedStringKey) -> some View {
        return Text("widthAnchor")
            .hidden()
            .overlay(alignment: .trailing) {
                Text(key)
            }
    }
}

struct AccessoryView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryView(viewModel: AccessoryViewModel(didChangeFileFormat: {_ in}))
    }
}
