//
//  Planet.swift
//
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation

public struct Planet: Decodable, Identifiable {
    public var id = UUID()
    public let name: String?
    public let rotationPeriod: String?
    public let orbitalPeriod: String?
    public let diameter: String?
    public let climate: String?
    public let gravity: String?
    public let terrain: String?
    public let surfaceWater: String?
    public let population: String?
    public let residents: [String]?
    public let films: [String]?
    public let created: String?
    public let edited: String?
    public let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surfaceWater = "surface_water"
        case population = "population"
        case residents = "residents"
        case films = "films"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        rotationPeriod = try values.decodeIfPresent(String.self, forKey: .rotationPeriod)
        orbitalPeriod = try values.decodeIfPresent(String.self, forKey: .orbitalPeriod)
        diameter = try values.decodeIfPresent(String.self, forKey: .diameter)
        climate = try values.decodeIfPresent(String.self, forKey: .climate)
        gravity = try values.decodeIfPresent(String.self, forKey: .gravity)
        terrain = try values.decodeIfPresent(String.self, forKey: .terrain)
        surfaceWater = try values.decodeIfPresent(String.self, forKey: .surfaceWater)
        population = try values.decodeIfPresent(String.self, forKey: .population)
        residents = try values.decodeIfPresent([String].self, forKey: .residents)
        films = try values.decodeIfPresent([String].self, forKey: .films)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        edited = try values.decodeIfPresent(String.self, forKey: .edited)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    public init(name: String?, rotationPeriod: String?, orbitalPeriod: String?, diameter: String?, climate: String?, gravity: String?, terrain: String?, surfaceWater: String?, population: String?, residents: [String]?, films: [String]?, created: String?, edited: String?, url: String?) {
        self.name = name
        self.rotationPeriod = rotationPeriod
        self.orbitalPeriod = orbitalPeriod
        self.diameter = diameter
        self.climate = climate
        self.gravity = gravity
        self.terrain = terrain
        self.surfaceWater = surfaceWater
        self.population = population
        self.residents = residents
        self.films = films
        self.created = created
        self.edited = edited
        self.url = url
    }
}
