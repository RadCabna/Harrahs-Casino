import SwiftUI

struct ProfileView: View {
    @Bindable var viewModel: ProfileViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: screenHeight * 0.02) {
                AppMenuHeaderLogo()

                ProfileHeaderView(
                    userName: viewModel.userName,
                    tier: viewModel.tier,
                    tierCredits: viewModel.tierCredits,
                    progress: viewModel.progressToNextTier,
                    tierProgressTitle: viewModel.tierProgressTitle,
                    upgradeTip: viewModel.upgradeTip,
                    avatarImage: viewModel.avatarImage
                )

                NavigationLink {
                    EditProfileView(viewModel: viewModel)
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Profile")
                            .font(AppTypography.body(0.019, weight: .semibold))
                    }
                    .foregroundStyle(AppColors.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: screenHeight * 0.052)
                    .glassCard()
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Edit profile")
            }
            .padding(.horizontal, contentHorizontalPadding)
            .padding(.vertical, screenHeight * 0.02)
        }
        .scrollIndicators(.hidden)
        .appScrollViewSupport()
        .appScreenBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        ProfileView(viewModel: ProfileViewModel())
    }
    .background(GradientBackgroundView())
}
