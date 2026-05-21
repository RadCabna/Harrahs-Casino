import SwiftUI
import UIKit

enum AppTypography {
    static func display(_ heightFactor: CGFloat) -> Font {
        font(name: "PlayfairDisplay-Bold", heightFactor: heightFactor, fallback: .system(size: ScreenLayout.height * heightFactor, weight: .bold, design: .serif))
    }

    static func accentTitle(_ heightFactor: CGFloat) -> Font {
        font(name: "Cinzel-Bold", heightFactor: heightFactor, fallback: .system(size: ScreenLayout.height * heightFactor, weight: .bold, design: .serif))
    }

    static func body(_ heightFactor: CGFloat, weight: Font.Weight = .regular) -> Font {
        let fontName = weight == .medium || weight == .semibold ? "Inter-Medium" : "Inter-Regular"
        let uiWeight: UIFont.Weight = weight == .medium ? .medium : (weight == .semibold ? .semibold : .regular)
        let size = ScreenLayout.height * heightFactor
        if UIFont(name: fontName, size: size) != nil {
            return .custom(fontName, size: size)
        }
        return .system(size: size, weight: weight)
    }

    static func balance(_ heightFactor: CGFloat) -> Font {
        .system(size: ScreenLayout.height * heightFactor, weight: .semibold, design: .monospaced)
    }

    private static func font(name: String, heightFactor: CGFloat, fallback: Font) -> Font {
        let size = ScreenLayout.height * heightFactor
        return UIFont(name: name, size: size) != nil ? .custom(name, size: size) : fallback
    }
}
