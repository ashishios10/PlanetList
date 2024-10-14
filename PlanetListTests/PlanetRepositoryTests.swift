//
//  PlanetRepositoryTests.swift
//  PlanetListTests
//
//  Created by Ashish Patel on 2024/10/14.
//

import Foundation
import XCTest
@testable import PlanetList

class PlanetRepositoryTests: XCTestCase {
    
    var serviceUnderTest: PlanetRepositoryImplementation!
    var mockNetworkManager = MockNetworkManagerProtocol()
    var mockPlanetRepositoryDb = MockPlanetRepositoryDb()
    
    override func setUp() {
        super.setUp()
        serviceUnderTest = PlanetRepositoryImplementation(networkManager: mockNetworkManager, dbRepository: mockPlanetRepositoryDb)
    }
    
    override func tearDown() {
        super.tearDown()
        XCTAssertTrue(mockNetworkManager.verify())
        XCTAssertTrue(mockPlanetRepositoryDb.verify())
        mockNetworkManager.resetCounts()
        mockPlanetRepositoryDb.resetCounts()
        serviceUnderTest = nil
    }
    
    func testPlanetsService_WhenGiveSuccess() async throws {
        do {
            mockNetworkManager.expectPerformRequest(response: try MockDataGenerator.getMockPlanets(), error: nil)
            mockPlanetRepositoryDb.expectInsertPlanets(error: nil)
            let response = try await serviceUnderTest.fetchPlanets(pageNo: 1)
            XCTAssertNotNil(response)
        } catch {
            XCTFail("API Call Fail")
        }
    }
    
    func testPlanetsService_WhenGiveFail() async throws {
        do {
            let expectedErrorMessage = "Unable to find records"
            let exptedError = MockDataGenerator.getGenerateError(messsage: expectedErrorMessage)
            mockPlanetRepositoryDb.expectFetchPlanets(error: exptedError)
            mockNetworkManager.expectPerformRequest(response: nil, error: exptedError)
            _ = try await self.serviceUnderTest.fetchPlanets(pageNo: 1)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testPlanetsServiceWhenServiceGivesFailThenLocalStorageSendResponse() async throws {
        do {
            let expectedErrorMessage = "Unable to find records"
            let exptedError = MockDataGenerator.getGenerateError(messsage: expectedErrorMessage)
            mockNetworkManager.expectPerformRequest(response: nil, error: exptedError)
            mockPlanetRepositoryDb.expectFetchPlanets(error: nil)
            let response = try await serviceUnderTest.fetchPlanets(pageNo: 1)
            XCTAssertNotNil(response)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
