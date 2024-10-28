//
//  CustomDecoder.swift
//  
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation

/// Custom decoder for json parsing
public final class CustomDecoder: JSONDecoder {
    public override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        do {
            super.keyDecodingStrategy = .convertFromSnakeCase
            return try super.decode(type, from: data)
        } catch {
            throw error
        }
    }
}
