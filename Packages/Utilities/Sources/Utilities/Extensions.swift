//
//  Extensions.swift
//
//
//  Created by Ashish Patel on 2024/10/11.
//


import Foundation
import SwiftUI

/// String extension
public extension String {
    func localized (bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
    
    func localizedWith(_ params: CVarArg...) -> String {
        return String(format: localized(), arguments: params)
    }
}

/// Text extension
public extension Text {
    func textDefaultSettings() -> some View {
        self.mediumFont(fontColor: Color.blackColor, size: .LARGE_FONT_SIZE)
    }
}

/// Color extension
public extension Color {
    static let blackColor = Color.black
}
