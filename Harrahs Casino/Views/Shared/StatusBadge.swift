import SwiftUI

struct StatusBadge: View {
    let status: AvailabilityStatus

    var body: some View {
        HStack(spacing: screenHeight * 0.005) {
            Image(systemName: status.systemImage)
                .font(AppTypography.body(0.013))
            Text(status.title)
                .font(AppTypography.body(0.013, weight: .semibold))
        }
        .foregroundStyle(AppColors.background)
        .padding(.horizontal, screenHeight * 0.012)
        .padding(.vertical, screenHeight * 0.006)
        .background(status.color)
        .clipShape(Capsule())
        .accessibilityLabel(status.title)
    }
}

#Preview {
    HStack {
        StatusBadge(status: .available)
        StatusBadge(status: .pending)
        StatusBadge(status: .occupied)
    }
    .padding()
    .background(AppColors.background)
}
