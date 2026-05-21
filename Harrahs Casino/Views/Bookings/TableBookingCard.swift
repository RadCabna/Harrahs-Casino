import SwiftUI

struct TableBookingCard: View {
    let booking: TableBooking
    var onCancel: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: screenHeight * 0.014) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: screenHeight * 0.007) {
                    Text(bookingHeadline)
                        .font(AppTypography.body(0.019, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)
                    Text(detailLine)
                        .font(AppTypography.body(0.0166))
                        .foregroundStyle(AppColors.textSecondary)
                    Text(booking.scheduleText)
                        .font(AppTypography.body(0.0166))
                        .foregroundStyle(AppColors.textSecondary)
                    Text("Status: \(booking.status.title)")
                        .font(AppTypography.body(0.0166, weight: .medium))
                        .foregroundStyle(statusColor)
                }
                Spacer()
            }

            if booking.status == .confirmed || booking.status == .pending {
                QRCodeCard(code: booking.confirmationCode, caption: "Digital Pass")
            }

            if booking.listTab == .active || booking.listTab == .upcoming {
                Button(role: .destructive, action: onCancel) {
                    Label("Cancel", systemImage: "xmark.circle")
                        .font(AppTypography.body(0.0178, weight: .semibold))
                        .foregroundStyle(AppColors.destructive)
                        .frame(maxWidth: .infinity, minHeight: screenHeight * 0.052)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(screenHeight * 0.045)
        .glassCard(isPremium: booking.isPremium)
    }

    private var bookingHeadline: String {
        if let ticketTitle = booking.ticketTitle {
            return "🎫 \(ticketTitle)"
        }
        return "🎲 \(booking.gameType.title)"
    }

    private var detailLine: String {
        if let entryFee = booking.eventEntryFee {
            return "Entry: \(entryFee)"
        }
        return "Limit: \(booking.betLimit.title)"
    }

    private var statusColor: Color {
        switch booking.status {
        case .confirmed: AppColors.available
        case .pending: AppColors.pending
        case .cancelled, .completed: AppColors.textSecondary
        }
    }
}

#Preview {
    TableBookingCard(
        booking: TableBooking(
            id: "b1",
            gameType: .blackjack,
            betLimit: .medium,
            scheduleText: "Today, 8:30–9:00 PM",
            status: .confirmed,
            confirmationCode: "HRH-8F2K-91XQ",
            listTab: .active,
            isPremium: true
        ),
        onCancel: {}
    )
    .padding()
    .background(AppColors.background)
}
