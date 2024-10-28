//
//  NetworkManager.swift
//
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation
import UIKit
import Utilities

/// MARK: - NetworkManager for bakend communication
public protocol NetworkManagerProtocol {
    func request<T: Decodable>(request: Request,
                               parameters: Encodable?) async throws -> T
}

public struct NetworkManager: NetworkManagerProtocol {
    
    public init() {}
    
    fileprivate func checkNetworkConnection() throws {
        guard Reachability.isConnectedToNetwork() else {
            throw APIError.noInternet
        }
    }
    
    public func request<T: Decodable>(request: Request,
                                      parameters: Encodable? = nil) async throws -> T  {
        
        let session = URLSession(configuration: .default)
        try checkNetworkConnection()
        let (data, httpResponse) = try await session.data(for: request as URLRequest)
        guard let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.hasValidResponseCode() else {
            throw APIError.invalidResponse
        }
        do {
            return try CustomDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.invalidResponse
        }
    }
}
