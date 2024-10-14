//
//  PlanetListViewModelTests.swift
//  PlanetListTests
//
//  Created by Ashish Patel on 2024/10/14.
//

import XCTest
@testable import PlanetList

class PlanetListViewModelTests: XCTestCase {
    
    var serviceUnderTest: PlanetListViewModel!
    var mockPlanetRepo = MockPlanetRepository()
    
    override func setUp() {
        super.setUp()
        serviceUnderTest = PlanetListViewModel(mockPlanetRepo)
    }
    
    override func tearDown() {
        serviceUnderTest = nil
        super.tearDown()
    }
    
    func testPerformFetchPlanetsForSuccessResponse() async {
        mockPlanetRepo.response = .success
        await self.serviceUnderTest.performFetchPlanets()
        let state = self.serviceUnderTest.state
        switch state {
        case .idle, .loading: break
        case .success(let loadedViewModel):
            XCTAssertNotNil(loadedViewModel.planets)
        case .failed(_):
            XCTFail("Fail")
        }
    }
    
    func testPerformFetchPlanetsForError() async {
        mockPlanetRepo.response = .error
        await self.serviceUnderTest.performFetchPlanets()
        let state = self.serviceUnderTest.state
        switch state {
        case .idle, .loading: break
        case .success(_):
            XCTFail("Fail")
        case .failed(let errorViewModel):
            XCTAssertNotNil(errorViewModel)
        }
    }
}
