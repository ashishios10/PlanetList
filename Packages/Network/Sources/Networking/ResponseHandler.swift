//
//  ResponseHandler.swift
//
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation

/// MARK: - API ResponseHandler
public enum ResponseHandler<T: Decodable> {
    case success(result: T)
    case failure(error: Error)
}

public extension HTTPURLResponse {
    ///This method will check response status code from the API responses
    func hasValidResponseCode() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
