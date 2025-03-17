//
//  Color+Extensions.swift
//  JoyFullOC
//
//  Created by Alassane Der on 13/03/2025.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


// MARK: - CustomColors accessibility
extension Color {
    static func accessiblePrimaryAccent(_ env: EnvironmentValues) -> Color {
        if env.accessibilityDifferentiateWithoutColor {
            return .blue /// Couleur neutre si différenciation activée
        }
        if env.accessibilityInvertColors {
            return Color(hex: "B24F4F") /// Couleur inversée
        }
        if env.colorScheme == .dark {
            return env.colorSchemeContrast == .increased ? Color(hex: "266E75") : Color(hex: "54D6E7")
        }
        return env.colorSchemeContrast == .increased ? Color(hex: "3C9DA8") : Color(hex: "4FB2BF")
    }
    
    static func accessibleBackground(_ env: EnvironmentValues) -> Color {
        if env.accessibilityReduceTransparency {
            return .white /// Fond solide pour éviter la transparence
        }
        if env.colorScheme == .dark {
            return env.colorSchemeContrast == .increased ? Color(hex: "101010") : Color(hex: "1C1C1E")
        }
        return env.colorSchemeContrast == .increased ? Color(hex: "DADADA") : Color(hex: "EFEFF4")
    }
}

/// check good colorration on waibaim.org for exmple 7.1 or 4.5 le plus petit
/// youtube Nick Vid accessibility colors
///
/// trouver une couleur : https://mycolor.space/?hex=%23EFEFF4&sub=1 et changer la couleur de sélection en mode clair
/// #FF00D5 ou #FF00E9
