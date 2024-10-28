//
//  APIError.swift
//
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation
import Utilities

/// MARK: - APIError for error handling
public enum APIError: Error {
    case noInternet
    case invalidURL
    case invalidResponse
    case timeOut
    case unknownError
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return ErrorMessage.noInternet.localizedText
        case .invalidURL:
            return ErrorMessage.invalidURL.localizedText
        case .invalidResponse:
            return ErrorMessage.invalidResponse.localizedText
        case .timeOut:
            return ErrorMessage.requestTimeOut.localizedText
        case .unknownError:
            return ErrorMessage.unknownError.localizedText
        }
    }
}
