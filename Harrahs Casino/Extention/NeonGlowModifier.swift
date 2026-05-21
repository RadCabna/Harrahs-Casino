import SwiftUI

struct NeonGlowModifier: ViewModifier {
    var intensity: CGFloat

    func body(content: Content) -> some View {
        content
            .shadow(color: AppColors.neonRedGlow, radius: ScreenLayout.height * 0.014 * intensity)
            .shadow(color: AppColors.neonGoldGlow, radius: ScreenLayout.height * 0.028 * intensity)
            .shadow(color: AppColors.brandRed.opacity(0.4), radius: ScreenLayout.height * 0.007 * intensity)
    }
}

extension View {
    func neonGlow(intensity: CGFloat = 1) -> some View {
        modifier(NeonGlowModifier(intensity: intensity))
    }
}
