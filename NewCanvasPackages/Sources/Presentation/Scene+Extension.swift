/*
 Scene+Extension.swift
 Presentation

 Created by Takuto Nakamura on 2024/11/09.
 
*/

import SwiftUI

extension Scene {
    func windowFloating() -> some Scene {
        if #available(macOS 15.0, *) {
            return windowLevel(.floating)
        } else {
            return self
        }
    }
}
