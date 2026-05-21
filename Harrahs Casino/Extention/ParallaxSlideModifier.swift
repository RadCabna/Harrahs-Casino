import SwiftUI

struct ParallaxSlideModifier: ViewModifier {
    var isActive: Bool

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    GradientBackgroundView(parallaxOffset: isActive ? -proxy.frame(in: .global).minX * 0.25 : 0)
                }
            )
    }
}

extension View {
    func parallaxSlideBackground(isActive: Bool = true) -> some View {
        modifier(ParallaxSlideModifier(isActive: isActive))
    }
}
