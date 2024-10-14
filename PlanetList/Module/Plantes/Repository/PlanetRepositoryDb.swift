//
//  PlanetRepositoryDb.swift
//  PlanetList
//
//  Created by Ashish Patel on 2024/10/12.
//

import Foundation
import Models
import CoreData

protocol PlanetRepositoryDb {
    func fetchPlanets() async throws -> PlanetDetails?
    func insertPlanets(planetDetails: PlanetDetails) async throws
}

struct PlanetRepositoryDbImplementation: PlanetRepositoryDb {
    var persistenceController = PersistenceController.shared
}

extension PlanetRepositoryDbImplementation {
    func fetchPlanets() async throws -> PlanetDetails? {
        let response = await Planet.allPlanetEntities()
        var planetDetails = PlanetDetails(count: 1, next: nil, previous: nil, planets: nil)
        if !response.isEmpty {
            let planets: [Planet] = response.compactMap { item in
                Planet(name: item.name, rotationPeriod: item.rotationPeriod, orbitalPeriod: item.orbitalPeriod, diameter: item.diameter, climate: item.climate, gravity: item.gravity, terrain: item.terrain, surfaceWater: item.surfaceWater, population: item.population, residents: item.residents?.components(separatedBy: "-"), films: item.films?.components(separatedBy: "-"), created: item.created, edited: item.edited, url: item.url?.absoluteString)
            }
            planetDetails.planets = planets
        }
        return planetDetails
    }
    
    func insertPlanets(planetDetails: PlanetDetails) async throws {
        if let planets = planetDetails.planets {
            _ = await planets.asyncForEach { planet in
                let entityExit = await Planet.entityExist(name: (planet.name ?? ""), created: (planet.created ?? ""))
                if !entityExit {
                    let entity = Planet.addNewItem()
                    entity.page = 1
                    entity.id = planet.id
                    entity.name = planet.name ?? ""
                    entity.rotationPeriod = planet.rotationPeriod ?? ""
                    entity.diameter = planet.diameter ?? ""
                    entity.climate = planet.climate ?? ""
                    entity.gravity = planet.gravity ?? ""
                    entity.terrain = planet.terrain ?? ""
                    entity.surfaceWater = planet.surfaceWater ?? ""
                    entity.population = planet.population ?? ""
                    entity.residents = planet.residents?.joined(separator: "-")
                    entity.films = planet.films?.joined(separator: "-")
                    entity.created = planet.created ?? ""
                    entity.edited = planet.edited ?? ""
                    entity.url =  URL(string: planet.url ?? "")
                }
            }
            try persistenceController.saveContext()
        }
    }
}

extension Sequence {
    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
}
