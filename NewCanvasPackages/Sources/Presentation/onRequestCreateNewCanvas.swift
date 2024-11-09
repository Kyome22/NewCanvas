/*
 onRequestCreateNewCanvas.swift
 Presentation

 Created by Takuto Nakamura on 2024/11/09.
 
*/

import Domain
import SwiftUI

typealias OnRequestCreateNewCanvasAction = (URL) -> Void

struct OnRequestCreateNewCanvas: ViewModifier {
    let action: OnRequestCreateNewCanvasAction

    func body(content: Content) -> some View {
        content.onReceive(ServicesProvider.shared.urlPublisher) { url in
            action(url)
        }
    }
}

public extension View {
    func onRequestCreateNewCanvas(perform action: @escaping (_ url: URL) -> Void) -> some View {
        modifier(OnRequestCreateNewCanvas(action: action))
    }
}
