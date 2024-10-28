//
//  ConfigurableFont.swift
//  
//
//  Created by Ashish Patel on 2024/10/14.
//

import SwiftUI

public enum FontSize: CGFloat {
    case SMALL_FONT_SIZE = 14.0
    case LARGE_FONT_SIZE = 16.0
    case XX_LARGE_FONT_SIZE = 24.0
    case XXX_LARGE_FONT_SIZE = 32.0
}

/// Internal ViewModifier that uses the system font that has a configurable size and color
struct ConfigurableFont: ViewModifier {
    var fontColor: Color
    var size: CGFloat
    var weight: Font.Weight
    func body(content: Content) -> some View {
        content
            .font(.custom("HelveticaNeue",
                          size: size)
            .weight(weight))
            .foregroundColor(fontColor)
    }
}

public extension View {
    /// Use this for medium weight fonts
    func mediumFont(fontColor: Color, size: FontSize) -> some View {
        self.customWeightConfigurableFont(fontColor: fontColor, size: size.rawValue, weight: .medium)
    }
    
    
    /// Use this bold weight fonts
    func boldFont(fontColor: Color, size: FontSize) -> some View {
        self.customWeightConfigurableFont(fontColor: fontColor, size: size.rawValue, weight: .bold)
    }
        
    /// Use this custom weight fonts
    private func customWeightConfigurableFont(fontColor: Color, size: CGFloat, weight: Font.Weight) -> some View {
        self.modifier(ConfigurableFont(fontColor: fontColor, size: size, weight: weight))
    }
}
