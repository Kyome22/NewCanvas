/*
 WorkspaceView.swift
 Presentation

 Created by Takuto Nakamura on 2024/11/09.
 
*/

import DataLayer
import Domain
import SwiftUI

struct WorkspaceView: View {
    @State private var viewModel: WorkspaceViewModel
    @Environment(\.dismissWindow) private var dismissWindow

    init(
        nsWorkspaceClient: NSWorkspaceClient,
        canvasService: CanvasService,
        logService: LogService
    ) {
        viewModel = .init(nsWorkspaceClient, canvasService, logService)
    }

    var body: some View {
        VStack(spacing: 20) {
            Label {
                Text("appTitle", bundle: .module)
            } icon: {
                Image(.icon)
            }
            Form {
                HStack(spacing: 0) {
                    TextField(value: $viewModel.width, formatter: formatter) {
                        Text("width", bundle: .module)
                    }
                    Text(verbatim: "px")
                }
                HStack(spacing: 4) {
                    TextField(value: $viewModel.height, formatter: formatter) {
                        Text("height", bundle: .module)
                    }
                    Text(verbatim: "px")
                }
                ColorPicker(selection: $viewModel.fillColor) {
                    Text("fillColor", bundle: .module)
                }
            }
            .fixedSize()
            Button {
                viewModel.isPresentedFileExporter = true
            } label: {
                Text("newCanvas", bundle: .module)
                    .frame(width: 150)
            }
            .controlSize(.large)
            .keyboardShortcut(.defaultAction)
        }
        .padding()
        .onAppear {
            viewModel.onAppear(screenName: String(describing: Self.self))
        }
        .onRequestCreateNewCanvas { url in
            viewModel.directoryURL = url
        }
        .fileExporter(
            isPresented: $viewModel.isPresentedFileExporter,
            document: viewModel.exportFile(),
            contentTypes: FileFormat.supportedFormats.map(\.type),
            defaultFilename: String(localized: "defaultName", bundle: .module),
            onCompletion: { result in
                viewModel.onCompletionFileExporter(result) {
                    dismissWindow()
                }
            }
        )
        .fileDialogDefaultDirectory(viewModel.directoryURL)
        .fileDialogMessage(Text("createCanvas", bundle: .module))
        .fileDialogConfirmationLabel(Text("saveOpen", bundle: .module))
    }

    private let formatter: Formatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()
}

#Preview {
    WorkspaceView(
        nsWorkspaceClient: .testValue,
        canvasService: .init(.testValue),
        logService: .init(.testValue)
    )
}
