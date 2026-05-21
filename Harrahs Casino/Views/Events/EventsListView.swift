import SwiftUI

struct EventsListView: View {
    @Bindable var viewModel: EventsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: screenHeight * 0.018) {
                AppMenuHeaderLogo()

                ForEach(viewModel.events) { event in
                    NavigationLink(value: event) {
                        TournamentEventCard(
                            event: event,
                            registrationStatus: viewModel.displayRegistrationStatus(for: event)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, contentHorizontalPadding)
            .padding(.vertical, screenHeight * 0.02)
        }
        .scrollIndicators(.hidden)
        .appScrollViewSupport()
        .appScreenBackground()
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(for: TournamentEvent.self) { event in
            EventDetailView(viewModel: viewModel, event: event)
        }
    }
}

#Preview {
    NavigationStack {
        EventsListView(
            viewModel: EventsViewModel(
                bookingsViewModel: MyBookingsViewModel(),
                profileViewModel: ProfileViewModel()
            )
        )
    }
    .background(GradientBackgroundView())
}
