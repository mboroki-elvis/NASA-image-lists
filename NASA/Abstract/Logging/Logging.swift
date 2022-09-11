//
//  Logging.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation
import os

enum Logging {
    static let osLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "data")

    static func logError(error: Error, file: String = #file, line: Int = #line) {
        os_log(
            "%@ [%@:%d] %{public}@%@",
            log: osLog,
            type: .fault,
            "💔",
            file,
            "\(line)",
            "\(error)",
            error.localizedDescription
        )
    }

    static func logDecodingError(error: DecodingError, file: String, line: Int) {
        let message: String
        let scope: DecodingError.Context
        switch error {
        case .typeMismatch(let type, let context):
            scope = context
            message = "Type '\(type)' mismatch: \(context.debugDescription)"
        case .valueNotFound(let value, let context):
            scope = context
            message = "Value '\(value)' not found: \(context.debugDescription)"
        case .keyNotFound(let key, let context):
            scope = context
            message = "Key '\(key)' not found: \(context.debugDescription)"
        case .dataCorrupted(let context):
            scope = context
            message = "Data corrupted"
        @unknown default:
            scope = DecodingError.Context(
                codingPath: [],
                debugDescription: error.errorDescription ?? "Unknown error occured while decoding"
            )
            message = "Unknown error occured"
        }
        os_log(
            "%@ [%@:%d] %{public}@%@",
            log: osLog,
            type: .fault,
            "💔",
            file,
            "\(line)",
            message,
            "\(error.errorDescription ?? ""), Path: \(scope.codingPath)"
        )
    }
}
