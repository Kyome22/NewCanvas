/*
 ServicesProvider.swift
 Domain

 Created by Takuto Nakamura on 2024/11/07.
 
*/

import AppKit
import Combine

@MainActor public final class ServicesProvider: NSObject {
    public static let shared = ServicesProvider()

    private let urlSubject = CurrentValueSubject<URL?, Never>(nil)
    public var urlPublisher: Publishers.Share<AnyPublisher<URL, Never>>

    override private init() {
        urlPublisher = urlSubject.compactMap(\.self).eraseToAnyPublisher().share()
        super.init()
    }

    @objc func createNewCanvas(
        _ pboard: NSPasteboard,
        userData: String,
        error errorPointer: AutoreleasingUnsafeMutablePointer<NSString?>
    ) {
        guard let urls = pboard.readObjects(forClasses: [NSURL.self]) as? [URL],
              let directoryURL = urls.first else {
            return
        }
        openSelfIfneeded()
        urlSubject.send(directoryURL)
    }

    // WORKAROUND
    private func openSelfIfneeded() {
        if #available(macOS 15.0, *),
           let bundleIdentifier = Bundle.main.bundleIdentifier,
           let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier) {
            NSWorkspace.shared.openApplication(at: url, configuration: .init())
        }
    }
}
