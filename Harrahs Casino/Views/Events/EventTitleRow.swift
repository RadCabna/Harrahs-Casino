import SwiftUI

struct EventTitleRow: View {
    let title: String
    let gameIconName: String?
    var titleSize: CGFloat = 0.024
    var iconSize: CGFloat = 0.044

    var body: some View {
        HStack(alignment: .center, spacing: screenHeight * 0.012) {
            if let gameIconName {
                Image(gameIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenHeight * iconSize, height: screenHeight * iconSize)
            }

            Text(title)
                .font(AppTypography.display(titleSize))
                .foregroundStyle(AppColors.textPrimary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    EventTitleRow(title: "Harrah's High Roller Poker Night", gameIconName: "iconPoker")
        .padding()
        .background(AppColors.background)
}
