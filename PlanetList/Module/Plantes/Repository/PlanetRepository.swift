//
//  PlanetRepository.swift
//  PlanetList
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation
import Networking
import Utilities
import Models

/// MARK: - Planet repository
protocol PlanetRepository {
    func fetchPlanets(pageNo: Int) async throws -> PlanetDetails
}

struct PlanetRepositoryImplementation: PlanetRepository {
    
    private let networkManager: NetworkManagerProtocol
    private var dbRepository: PlanetRepositoryDb

    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         dbRepository: PlanetRepositoryDb = PlanetRepositoryDbImplementation()) {
        self.networkManager = networkManager
        self.dbRepository = dbRepository
    }
    
    private func fetchFromLocalStorage() async throws -> PlanetDetails? {
        return try await dbRepository.fetchPlanets()
    }
    
    private func inserOrUpdateLocalStorage(details: PlanetDetails) async throws {
        try await dbRepository.insertPlanets(planetDetails: details)
    }
}

extension PlanetRepositoryImplementation {
    func fetchPlanets(pageNo: Int) async throws -> PlanetDetails {
        guard let request = RequestConfig.fetchPlanets(pageNo: pageNo).value else { throw APIError.unknownError }
        do {
            let response: PlanetDetails = try await networkManager.request(request: request, parameters: nil)
            try await inserOrUpdateLocalStorage(details: response)
            return response
        } catch {
            if let planets = try await fetchFromLocalStorage() {
                return planets
            }
            throw error
        }
    }
}
