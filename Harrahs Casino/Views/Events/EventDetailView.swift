import SwiftUI

struct EventDetailView: View {
    @Bindable var viewModel: EventsViewModel
    let event: TournamentEvent

    private var isRegistered: Bool {
        viewModel.isRegistered(for: event.id)
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: screenHeight * 0.02) {
                    Image(event.bannerImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: screenHeight * 0.24)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.02))
                        .clipped()

                    EventRegistrationBadge(status: viewModel.displayRegistrationStatus(for: event))

                    EventTitleRow(
                        title: event.title,
                        gameIconName: event.gameIconName,
                        titleSize: 0.032,
                        iconSize: 0.052
                    )

                    detailRow("Type", event.eventType)
                    detailRow("Schedule", event.scheduleText)
                    detailRow("Entry", event.entryFee)
                    detailRow("Prizes", event.prizeDescription)

                    Text(event.detailDescription)
                        .font(AppTypography.body(0.019))
                        .foregroundStyle(AppColors.textSecondary)

                    Text("Rules")
                        .font(AppTypography.display(0.024))
                        .foregroundStyle(AppColors.textPrimary)

                    ForEach(event.rules, id: \.self) { rule in
                        HStack(alignment: .top, spacing: screenHeight * 0.009) {
                            Text("•")
                                .foregroundStyle(AppColors.brandGold)
                            Text(rule)
                                .font(AppTypography.body(0.0166))
                                .foregroundStyle(AppColors.textSecondary)
                        }
                    }

                    if event.registrationStatus == .registrationOpen {
                        PrimaryButton(
                            title: isRegistered ? "Registered" : "Register",
                            action: {
                                viewModel.register(for: event)
                            },
                            isEnabled: !isRegistered
                        )
                    }
                }
                .padding(.horizontal, contentHorizontalPadding)
                .padding(.vertical, screenHeight * 0.02)
            }
            .scrollIndicators(.hidden)
            .appScrollViewSupport()
            .appScreenBackground()

            if viewModel.showRegistrationTicket {
                TicketSuccessView(
                    confirmationCode: viewModel.registrationConfirmationCode,
                    title: viewModel.registrationTicketTitle,
                    onDone: { viewModel.dismissRegistrationTicket() }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(2)
            }
        }
        .animation(.spring(response: 0.55, dampingFraction: 0.82), value: viewModel.showRegistrationTicket)
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private func detailRow(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: screenHeight * 0.005) {
            Text(label)
                .font(AppTypography.body(0.0142))
                .foregroundStyle(AppColors.textSecondary)
            Text(value)
                .font(AppTypography.body(0.0178, weight: .medium))
                .foregroundStyle(AppColors.textPrimary)
        }
    }
}

#Preview {
    let viewModel = EventsViewModel(
        bookingsViewModel: MyBookingsViewModel(),
        profileViewModel: ProfileViewModel()
    )
    return NavigationStack {
        EventDetailView(viewModel: viewModel, event: viewModel.events[0])
    }
    .background(GradientBackgroundView())
}
