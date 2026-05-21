import SwiftUI

struct ProfileHeaderView: View {
    let userName: String
    let tier: LoyaltyTier
    let tierCredits: Int
    let progress: Double
    let tierProgressTitle: String
    let upgradeTip: String
    let avatarImage: UIImage?

    var body: some View {
        VStack(spacing: screenHeight * 0.018) {
            AvatarView(image: avatarImage, size: screenHeight * 0.11)

            Text(userName)
                .font(AppTypography.display(0.03))
                .foregroundStyle(AppColors.textPrimary)

            LoyaltyTierBadge(tier: tier)

            HStack(spacing: screenHeight * 0.007) {
                Text("Experience")
                    .font(AppTypography.body(0.0166))
                    .foregroundStyle(AppColors.textSecondary)

                Spacer()

                Text(tierCredits.formatted(.number.grouping(.automatic)))
                    .font(AppTypography.balance(0.026))
                    .foregroundStyle(AppColors.textPrimary)
            }

            VStack(alignment: .leading, spacing: screenHeight * 0.01) {
                Text(tierProgressTitle)
                    .font(AppTypography.body(0.0166, weight: .semibold))
                    .foregroundStyle(AppColors.textPrimary)

                LoyaltyProgressBar(progress: progress)

                Text(upgradeTip)
                    .font(AppTypography.body(0.0154))
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
        .padding(screenHeight * 0.05)
        .glassCard(isPremium: tier == .diamond || tier == .sevenStars)
    }
}

#Preview {
    ProfileHeaderView(
        userName: "Alex Morgan",
        tier: .gold,
        tierCredits: 3,
        progress: 0.6,
        tierProgressTitle: "Progress to Platinum",
        upgradeTip: "Book 2 more tables to reach Platinum",
        avatarImage: nil
    )
    .padding()
    .background(AppColors.background)
}
