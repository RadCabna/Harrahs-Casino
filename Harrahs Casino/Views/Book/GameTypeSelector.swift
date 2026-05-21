import SwiftUI

struct GameTypeSelector: View {
    @Binding var selection: GameType

    var body: some View {
        VStack(alignment: .leading, spacing: screenHeight * 0.01) {
            Text("Game Type")
                .font(AppTypography.body(0.0166, weight: .medium))
                .foregroundStyle(AppColors.textSecondary)

            HStack(spacing: screenHeight * 0.008) {
                ForEach(GameType.allCases) { type in
                    gameButton(type)
                }
            }
        }
    }

    private func gameButton(_ type: GameType) -> some View {
        let isSelected = selection == type
        return Button {
            AppHaptics.selection()
            selection = type
        } label: {
            VStack(spacing: screenHeight * 0.006) {
                Image(type.iconImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight * 0.034)

                Text(type.title)
                    .font(AppTypography.body(0.011, weight: .medium))
                    .foregroundStyle(isSelected ? AppColors.white : AppColors.textSecondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity)
            .frame(height: screenHeight * 0.078)
            .background(isSelected ? AppColors.brandRed : AppColors.fieldBackground)
            .overlay(
                RoundedRectangle(cornerRadius: screenHeight * 0.01)
                    .stroke(isSelected ? AppColors.brandRed : AppColors.fieldBorder, lineWidth: screenHeight * 0.0012)
            )
            .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.01))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(type.title)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var game = GameType.blackjack
        var body: some View {
            GameTypeSelector(selection: $game)
                .padding(.horizontal, ScreenLayout.horizontalPadding)
                .background(AppColors.background)
        }
    }
    return PreviewWrapper()
}
