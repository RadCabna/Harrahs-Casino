import SwiftUI
import UIKit

enum ScreenLayout {
    static let contentWidthRatio: CGFloat = 0.95

    static var height: CGFloat {
        let bounds = UIScreen.main.bounds
        return max(bounds.width, bounds.height)
    }

    static var width: CGFloat {
        let bounds = UIScreen.main.bounds
        return min(bounds.width, bounds.height)
    }

    static var horizontalPadding: CGFloat {
        width * (1 - contentWidthRatio) / 2
    }

    static func scaled(_ factor: CGFloat) -> CGFloat {
        height * factor
    }
}

extension View {
    var screenHeight: CGFloat {
        ScreenLayout.height
    }

    var contentHorizontalPadding: CGFloat {
        ScreenLayout.horizontalPadding
    }
}
