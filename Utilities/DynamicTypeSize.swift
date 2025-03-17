//
//  DynamicTypeSize.swift
//  JoyFullOC
//
//  Created by Alassane Der on 16/03/2025.
//

import SwiftUI

import SwiftUI

extension DynamicTypeSize {
    
    // MARK: - item view
    static func imageHeight(for dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small:
            return 90
        case .medium:
            return 120
        case .large:
            return 150
        case .xLarge:
            return 180
        case .xxLarge, .xxxLarge:
            return 210
        case .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5:
            return 240
        @unknown default:
            return 180
        }
    }
    
    static func imageWidth(for dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small:
            return 180
        case .medium:
            return 190
        case .large:
            return 200
        case .xLarge:
            return 220
        case .xxLarge, .xxxLarge:
            return 240
        case .accessibility1, .accessibility2:
            return 270
        case .accessibility3, .accessibility4, .accessibility5:
            return 380
        @unknown default:
            return 190
        }
    }
    
    static func priceCellHeight(for dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small:
            return 60
        case .medium, .large, .xLarge:
            return 70
        case .xxLarge, .xxxLarge:
            return 80
            
        case .accessibility1, .accessibility2:
            return 110
        case .accessibility3, .accessibility4, .accessibility5:
            return 160
        @unknown default:
            return 80
        }
    }
    
    
    
    // MARK: - detail view
    static func profilePicSize(for dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small:
            return 40
        case .medium:
            return 50
        case .large:
            return 65
        case .xLarge:
            return 75
        case .xxLarge, .xxxLarge, .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5:
            return 80
        @unknown default:
            return 50
        }
    }
    
    static func iconSize(for dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small:
            return 20
        case .medium:
            return 25
        case .large:
            return 30
        case .xLarge, .xxLarge, .xxxLarge, .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5:
            return 35
        @unknown default:
            return 25
        }
    }
    
    static func textEditorHeight(for dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small:
            return 50
        case .medium:
            return 60
        case .large:
            return 70
        case .xLarge:
            return 80
        case .xxLarge, .xxxLarge:
            return 90
        case .accessibility1, .accessibility2, .accessibility3:
            return 100
        case .accessibility4, .accessibility5:
            return 150
        @unknown default:
            return 60
        }
    }
    
    
    ///chat
    struct UIContext {
        let isIPad: Bool
        let isLandscape: Bool
        let screenHeight: CGFloat
    }


    static func imageHeightDyn(for dynamicTypeSize: DynamicTypeSize, context: UIContext) -> CGFloat {
        let baseSize: CGFloat = context.isIPad ? context.screenHeight * 0.2 : context.screenHeight * 0.15
        let multiplier: CGFloat = context.isLandscape ? 0.8 : 1.0

        switch dynamicTypeSize {
        case .xSmall, .small: return baseSize * 0.7 * multiplier
        case .medium: return baseSize * 0.9 * multiplier
        case .large: return baseSize * 1.1 * multiplier
        case .xLarge: return baseSize * 1.3 * multiplier
        case .xxLarge, .xxxLarge: return baseSize * 1.5 * multiplier
        case .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5:
            return baseSize * 1.8 * multiplier
        @unknown default:
            return baseSize * 1.2 * multiplier
        }
    }

    
}


