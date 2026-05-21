import SwiftUI

struct TournamentEventCard: View {
    let event: TournamentEvent
    let registrationStatus: EventRegistrationStatus

    var body: some View {
        VStack(alignment: .leading, spacing: screenHeight * 0) {
            ZStack(alignment: .bottomLeading) {
                Image(event.bannerImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: screenHeight * 0.17)
                    .frame(maxWidth: .infinity)
                    .clipped()
                AppColors.eventOverlayGradient
                EventRegistrationBadge(status: registrationStatus)
                    .padding(screenHeight * 0.04)
            }

            VStack(alignment: .leading, spacing: screenHeight * 0.008) {
                EventTitleRow(title: event.title, gameIconName: event.gameIconName)

                Text(event.eventType)
                    .font(AppTypography.body(0.0154))
                    .foregroundStyle(AppColors.brandGold)

                HStack {
                    Label(event.scheduleText, systemImage: "calendar")
                    Spacer(minLength: 8)
                    Text(event.entryFee)
                        .lineLimit(1)
                }
                .font(AppTypography.body(0.0142))
                .foregroundStyle(AppColors.textSecondary)

                Text(event.prizeDescription)
                    .font(AppTypography.body(0.0142, weight: .medium))
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(2)
            }
            .padding(screenHeight * 0.045)
        }
        .glassCard()
    }
}

#Preview {
    let viewModel = EventsViewModel(
        bookingsViewModel: MyBookingsViewModel(),
        profileViewModel: ProfileViewModel()
    )
    TournamentEventCard(
        event: viewModel.events[0],
        registrationStatus: viewModel.displayRegistrationStatus(for: viewModel.events[0])
    )
        .padding()
        .background(AppColors.background)
}
