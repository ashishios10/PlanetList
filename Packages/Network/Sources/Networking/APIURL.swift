//
//  APIURL.swift
//
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation

/// APIBaseURL
enum APIBaseURL: String {
    
    case baseURLLive = "https://swapi.dev/api"
    
    static func getBaseURL() -> String {
        switch AppEnvironment.shared.environmentType {
        case .production:
            return APIBaseURL.baseURLLive.rawValue
        }
    }
}

public enum APIURL {
    case getPlanets
    case none
    
    public func getURL() -> String {
        let baseURL = APIBaseURL.getBaseURL()
        switch self {
        case .getPlanets:
            return baseURL + "/planets/?page=%d"
        case .none:
            return ""
        }
    }
}

