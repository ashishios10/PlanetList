//
//  MockPlanetRepositoryDb.swift
//  PlanetListTests
//
//  Created by Ashish Patel on 2024/10/14.
//

import Foundation
import Models

@testable import PlanetList

final class MockPlanetRepositoryDb: NSObject {
    private var configureInsertRequestCount = 0
    private var configureFetchRequestCount = 0
    private var expectedError: NSError?
    func expectInsertPlanets(error: NSError?) {
        self.expectedError = error
        self.configureInsertRequestCount += 1
    }
    
    func expectFetchPlanets(error: NSError?) {
        self.expectedError = error
        self.configureFetchRequestCount += 1
    }
    
    func resetCounts() {
        configureInsertRequestCount = 0
        configureFetchRequestCount = 0
    }
    
    func verify() -> Bool {
        return configureInsertRequestCount == 0 && configureFetchRequestCount == 0
    }
}

extension MockPlanetRepositoryDb: PlanetRepositoryDb {
    func fetchPlanets() async throws -> PlanetDetails? {
        configureFetchRequestCount -= 1
        guard expectedError == nil else { throw expectedError! }
        return try MockDataGenerator.mockPlanetDetails()
    }
    
    func insertPlanets(planetDetails: PlanetDetails) async throws {
        configureInsertRequestCount -= 1
        guard expectedError == nil else { throw expectedError! }
    }
}
