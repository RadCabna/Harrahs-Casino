import SwiftUI

struct GlassCardModifier: ViewModifier {
    var isPremium: Bool = false
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(AppColors.glassFill)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(.ultraThinMaterial)
                            .opacity(0.35)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        isPremium ? AppColors.glassGoldStroke : AppColors.glassStroke,
                        lineWidth: isPremium ? ScreenLayout.height * 0.0018 : ScreenLayout.height * 0.0012
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension View {
    func glassCard(isPremium: Bool = false, cornerRadius: CGFloat? = nil) -> some View {
        modifier(GlassCardModifier(
            isPremium: isPremium,
            cornerRadius: cornerRadius ?? screenHeight * 0.02
        ))
    }
}
