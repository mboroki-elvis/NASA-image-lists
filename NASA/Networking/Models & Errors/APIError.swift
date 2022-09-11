//
//  APIError.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation

enum APIError: Error, Equatable {
    case empty
    case authError
    case withError(Error, String, Int)

    // MARK: Internal

    var userFriendlyMessage: String {
        switch self {
        case .empty:
            return "Ooops! seems like no items were found"
        case .authError:
            return "Ooops! could not authenticate you"
        case .withError(let error, let file, let line):
            if let decodingError = error as? DecodingError {
                Logging.logDecodingError(error: decodingError, file: file, line: line)
                return handleDecodingErrors(decodingError)
            } else if let urlError = error as? URLError {
                Logging.logError(error: urlError, file: file, line: line)
                return handleURLErrors(urlError)
            }
            return "Ooops! internal error please retry later"
        }
    }

    var canRetry: Bool {
        switch self {
        case .empty:
            return false
        case .authError:
            return false
        case .withError(let error, _, _):
            if let decodingError = error as? DecodingError {
                return handleRetryDecodingErrors(decodingError)
            } else if let urlError = error as? URLError {
                return handleRetryURLError(urlError)
            }
            return false
        }
    }

    static func == (lhs: APIError, rhs: APIError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }

    // MARK: Private

    private func handleURLErrors(_ error: URLError) -> String {
        if error.code == URLError.Code.networkConnectionLost {
            return "Seems like you do not have an active internect connection, please check and retry"
        } else if error.code == URLError.Code.notConnectedToInternet {
            return "Seems like you do not have an active internect connection, please check and retry"
        } else if error.code == URLError.Code.timedOut {
            return "The request timed out, please try again"
        }
        return "Ooops! internal error please retry later"
    }

    private func handleDecodingErrors(_ error: DecodingError) -> String {
        switch error {
        case .typeMismatch:
            return "Ooops! Looks like we can't do that, we are working to resolve this"
        case .valueNotFound:
            return "Ooops! we encountered unexpected null data, we are working to resolve this"
        case .keyNotFound:
            return "Ooops! some data seems to be missing, we are working to resolve this"
        case .dataCorrupted:
            return "Ooops! seems like we could not read the data, would you like to try again?"
        @unknown default:
            return "Ooops! Something strange occured please allow us to resolve it"
        }
    }

    private func handleRetryDecodingErrors(_ error: DecodingError) -> Bool {
        switch error {
        case .typeMismatch:
            return false
        case .valueNotFound:
            return false
        case .keyNotFound:
            return false
        case .dataCorrupted:
            return true
        @unknown default:
            return false
        }
    }

    private func handleRetryURLError(_ error: URLError) -> Bool {
        if error.code == URLError.Code.networkConnectionLost {
            return true
        } else if error.code == URLError.Code.notConnectedToInternet {
            return true
        } else if error.code == URLError.Code.timedOut {
            return true
        }
        return false
    }
}
