//
//  Planets.swift
//
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation

public struct PlanetDetails: Decodable, Identifiable {
    public var id = UUID()
    public let count: Int?
    public let next: String?
    public let previous: String?
    public var planets: [Planet]?
    
    public enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
        planets = try values.decodeIfPresent([Planet].self, forKey: .results)
    }
    
    public init(count: Int?, next: String?, previous: String?, planets: [Planet]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.planets = planets
    }
}
