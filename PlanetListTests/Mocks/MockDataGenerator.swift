//
//  MockDataGenerator.swift
//  PlanetListTests
//
//  Created by Ashish Patel on 2024/10/14.
//

import Foundation
import Networking
import Models
import Utilities

@testable import PlanetList

final class MockDataGenerator {
    static func mockPlanetDetails() throws -> PlanetDetails {
        do {
            let data = try getMockPlanets()            
            let response = try CustomDecoder().decode(PlanetDetails.self, from: data)
            return response
        } catch {
            throw APIError.unknownError
        }
    }
    
    static func getMockPlanets() throws -> Data {
        guard let path = Bundle.main.path(forResource: "PlanetData", ofType: "json") else { throw APIError.invalidURL }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            throw APIError.unknownError
        }
    }
    
    static func getGenerateError(messsage: String) -> NSError? {
        return NSError(domain: "com.example.error",
                       code: 0,
                       userInfo: [NSLocalizedDescriptionKey: messsage])
    }
}
