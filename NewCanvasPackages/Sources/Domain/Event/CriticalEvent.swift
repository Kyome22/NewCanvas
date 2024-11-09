/*
 CriticalEvent.swift
 Domain

 Created by Takuto Nakamura on 2024/11/07.
 
*/

import Logging

public enum CriticalEvent {
    case failedWriteData(any Error)
    case failedSaveFile(any Error)

    public var message: Logger.Message {
        switch self {
        case .failedWriteData:
            "Failed to write data."
        case .failedSaveFile:
            "Failed to save file."
        }
    }

    public var metadata: Logger.Metadata? {
        switch self {
        case let .failedWriteData(error),
            let .failedSaveFile(error):
            ["cause": "\(error.localizedDescription)"]
        }
    }
}
