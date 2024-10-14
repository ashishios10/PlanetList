//
//  PlanetRepository.swift
//  PlanetListTests
//
//  Created by Ashish Patel on 2024/10/14.
//

import Foundation
import Networking
import Models

@testable import PlanetList

enum MockResponse {
    case success
    case error
}

final class MockPlanetRepository: PlanetRepository {
    var response: MockResponse = .success
    
    func fetchPlanets(pageNo: Int) async throws -> PlanetDetails {
        switch response {
        case .success:
            if !(Reachability.isConnectedToNetwork()) {
                throw APIError.noInternet
            }
            do {
                return try MockDataGenerator.mockPlanetDetails()
            } catch {
                throw error
            }
            
        case .error:
            throw APIError.invalidResponse
        }
    }
}
