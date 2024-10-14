//
//  MockNetworkManagerProtocol.swift
//  PlanetListTests
//
//  Created by Ashish Patel on 2024/10/14.
//

import Foundation
import Networking
import Utilities
@testable import PlanetList

final class MockNetworkManagerProtocol: NSObject {
    private var configureServiceClientCount = 0
    private var expectedResponse: Data?
    private var expectedError: NSError?
    func expectPerformRequest(response: Data?,
                              error: NSError?) {
        self.expectedResponse = response
        self.expectedError = error
        self.configureServiceClientCount += 1
    }
    func resetCounts() {
        configureServiceClientCount = 0
    }
    func verify() -> Bool {
        return configureServiceClientCount == 0
    }
}

extension MockNetworkManagerProtocol: NetworkManagerProtocol {
    func request<T>(request: Networking.Request, parameters: Encodable?) async throws -> T where T : Decodable {
        configureServiceClientCount -= 1
        guard expectedError == nil else { throw expectedError! }
        do {
            let response = try CustomDecoder().decode(T.self, from: expectedResponse!)
            return response
        } catch {
            throw error
        }
    }
}
