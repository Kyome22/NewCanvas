/*
 View+Extension.swift
 Presentation

 Created by Takuto Nakamura on 2024/11/09.
 
*/

import SwiftUI

public extension View {
    func windowMinimizeDisabled() -> some View {
        if #available(macOS 15.0, *) {
            return windowMinimizeBehavior(.disabled)
        } else {
            return self
        }
    }
}
