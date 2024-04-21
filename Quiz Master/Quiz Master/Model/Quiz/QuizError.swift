//
//  QuizError.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation

enum QuizError: Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension QuizError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Missing data", comment: "")
        case .networkError:
            return NSLocalizedString("Poor internet connection", comment: "")
        case .unexpectedError:
            return NSLocalizedString("Unexpected error", comment: "")
        }
    }
}
