import SwiftUI

struct EventRegistrationBadge: View {
    let status: EventRegistrationStatus

    var body: some View {
        Text(status.title)
            .font(AppTypography.body(0.013, weight: .semibold))
            .foregroundStyle(AppColors.background)
            .padding(.horizontal, screenHeight * 0.012)
            .padding(.vertical, screenHeight * 0.006)
            .background(status.color)
            .clipShape(Capsule())
    }
}

#Preview {
    VStack(spacing: ScreenLayout.scaled(0.009)) {
        EventRegistrationBadge(status: .registrationOpen)
        EventRegistrationBadge(status: .waitlist)
        EventRegistrationBadge(status: .spotsRemaining(12))
        EventRegistrationBadge(status: .registered)
    }
    .padding()
    .background(AppColors.background)
}
