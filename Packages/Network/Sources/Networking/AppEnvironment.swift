//
//  AppEnvironment.swift
//  
//
//  Created by Ashish Patel on 2024/10/11.
//

import Foundation

/// AppEnvironment
enum EnvironmentType {
    case production
}

final class AppEnvironment {
    static let shared = AppEnvironment()
    var environmentType: EnvironmentType = .production
}
