import SwiftUI

struct MyBookingsView: View {
    @Bindable var viewModel: MyBookingsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: screenHeight * 0.018) {
                AppMenuHeaderLogo()

                BookingsTabPicker(selectedTab: $viewModel.selectedTab)

                bookingsContent
            }
            .padding(.horizontal, contentHorizontalPadding)
            .padding(.vertical, screenHeight * 0.02)
        }
        .scrollIndicators(.hidden)
        .appScrollViewSupport()
        .appScreenBackground()
        .toolbar(.hidden, for: .navigationBar)
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedTab)
    }

    @ViewBuilder
    private var bookingsContent: some View {
        let bookings = viewModel.filteredBookings

        if bookings.isEmpty {
            emptyState
        } else if bookings.count == 1, let booking = bookings.first {
            TableBookingCard(booking: booking) {
                viewModel.cancelBooking(id: booking.id)
            }
        } else {
            VStack(spacing: screenHeight * 0.018) {
                ForEach(bookings) { booking in
                    TableBookingCard(booking: booking) {
                        viewModel.cancelBooking(id: booking.id)
                    }
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: screenHeight * 0.012) {
            Image(systemName: "ticket")
                .font(.system(size: screenHeight * 0.05))
                .foregroundStyle(AppColors.brandGold.opacity(0.6))
            Text("No bookings in this section")
                .font(AppTypography.body(0.019))
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, screenHeight * 0.08)
        .glassCard()
    }
}

#Preview {
    NavigationStack {
        MyBookingsView(viewModel: MyBookingsViewModel())
    }
    .background(GradientBackgroundView())
}
