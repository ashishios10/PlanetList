//
//  ErrorMessage.swift
//  
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation

/// Error messages with localized
public enum ErrorMessage: String {
    case invalidURL
    case noInternet
    case invalidResponse
    case requestTimeOut
    case unknownError
    
    public var localizedText: String {
        switch self {
        case .invalidURL:
            return "app.invalidURL.error".localized()
        case .noInternet:
            return "app.noInternet.error".localized()
        case .invalidResponse:
            return "app.invalidResponse.error".localized()
        case .requestTimeOut:
            return "app.requestTimeOut.error".localized()
        case .unknownError:
            return "app.unknownError.error".localized()
        }
    }
}
