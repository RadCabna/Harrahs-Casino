import SwiftUI

struct LoyaltyUpgradeOverlay: View {
    let tier: LoyaltyTier
    var onDismiss: () -> Void

    @State private var flashOpacity: Double = 0
    @State private var contentScale: CGFloat = 0.6
    @State private var contentOpacity: Double = 0

    var body: some View {
        ZStack {
            AppColors.brandGold.opacity(flashOpacity)
                .ignoresSafeArea()

            ConfettiView(isActive: true)

            VStack(spacing: screenHeight * 0.02) {
                Image(tier.statusImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight * 0.09)
                    .neonGlow(intensity: 1.2)

                Text("Tier Upgraded")
                    .font(AppTypography.display(0.034))
                    .foregroundStyle(AppColors.white)

                Text(tier.title)
                    .font(AppTypography.accentTitle(0.028))
                    .foregroundStyle(AppColors.brandGold)
                    .multilineTextAlignment(.center)
            }
            .scaleEffect(contentScale)
            .opacity(contentOpacity)

            VStack {
                Spacer()
                PrimaryButton(title: "Continue", action: onDismiss)
                    .padding(.horizontal, contentHorizontalPadding)
                    .padding(.bottom, screenHeight * 0.04)
            }
        }
        .onAppear {
            AppHaptics.success()
            withAnimation(.easeOut(duration: 0.25)) {
                flashOpacity = 0.35
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.1)) {
                contentScale = 1
                contentOpacity = 1
            }
        }
    }
}

#Preview {
    LoyaltyUpgradeOverlay(tier: .platinum, onDismiss: {})
}
