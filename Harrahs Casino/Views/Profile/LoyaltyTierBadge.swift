import SwiftUI

struct LoyaltyTierBadge: View {
    let tier: LoyaltyTier

    var body: some View {
        HStack(spacing: screenHeight * 0.01) {
            Image(tier.statusImageName)
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight * 0.096)

            Text(tier.title)
                .font(AppTypography.body(0.019, weight: .semibold))
                .foregroundStyle(AppColors.brandGold)
        }
        .accessibilityLabel("\(tier.title) loyalty tier")
    }
}

#Preview {
    VStack(spacing: ScreenLayout.scaled(0.016)) {
        ForEach(LoyaltyTier.allCases) { tier in
            LoyaltyTierBadge(tier: tier)
        }
    }
    .padding()
    .background(AppColors.background)
}
