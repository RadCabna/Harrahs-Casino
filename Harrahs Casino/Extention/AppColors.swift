import SwiftUI

enum AppColors {
    static let background = Color(hex: 0x000000)
    static let backgroundGradientTop = Color(hex: 0x1A0008)
    static let backgroundGradientBottom = Color(hex: 0x000000)

    static let brandRed = Color(hex: 0xE31837)
    static let brandRedDark = Color(hex: 0xA81028)
    static let white = Color(hex: 0xFFFFFF)
    static let brandGold = Color(hex: 0xFFD700)
    static let brandGoldMuted = Color(hex: 0xC9A800)

    static let available = Color(hex: 0x00C853)
    static let pending = Color(hex: 0xFFB300)
    static let occupied = Color(hex: 0xEF5350)

    static let textPrimary = white
    static let textSecondary = Color(hex: 0xB8B8B8)
    static let placeholder = Color(hex: 0x8A8A8A)
    static let fieldBackground = Color(hex: 0x141414)
    static let fieldBorder = Color(hex: 0x2E2E2E)
    static let fieldBorderFocused = brandRed
    static let glassFill = Color.white.opacity(0.08)
    static let glassStroke = Color.white.opacity(0.18)
    static let glassGoldStroke = brandGold.opacity(0.65)
    static let destructive = occupied
    static let neonRedGlow = brandRed.opacity(0.85)
    static let neonGoldGlow = brandGold.opacity(0.55)

    static var primaryButtonGradient: LinearGradient {
        LinearGradient(
            colors: [brandRed, brandRedDark],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static var premiumGoldGradient: LinearGradient {
        LinearGradient(
            colors: [brandGold, brandGoldMuted],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    static var eventOverlayGradient: LinearGradient {
        LinearGradient(
            colors: [Color.clear, background.opacity(0.35), background.opacity(0.92)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

extension Color {
    init(hex: UInt, opacity: Double = 1) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
