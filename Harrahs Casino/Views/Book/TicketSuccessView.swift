import SwiftUI

struct TicketSuccessView: View {
    let confirmationCode: String
    let title: String
    var onDone: () -> Void

    @State private var ticketOffset: CGFloat = ScreenLayout.scaled(0.47)
    @State private var ticketRotation: Double = -8
    @State private var ticketOpacity: Double = 0

    var body: some View {
        VStack(spacing: screenHeight * 0.028) {
            Text("Reservation Confirmed")
                .font(AppTypography.display(0.03))
                .foregroundStyle(AppColors.textPrimary)

            VStack(spacing: screenHeight * 0.02) {
                Image(systemName: "ticket.fill")
                    .font(.system(size: screenHeight * 0.05))
                    .foregroundStyle(AppColors.brandGold)

                Text(title)
                    .font(AppTypography.accentTitle(0.022))
                    .foregroundStyle(AppColors.white)

                QRCodeCard(code: confirmationCode, caption: "Your digital pass")
            }
            .padding(screenHeight * 0.05)
            .glassCard(isPremium: true)
            .offset(y: ticketOffset)
            .rotationEffect(.degrees(ticketRotation))
            .opacity(ticketOpacity)

            PrimaryButton(title: "Done", action: onDone)
        }
        .padding(.horizontal, contentHorizontalPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appScreenBackground()
        .onAppear {
            AppHaptics.success()
            AppSounds.ticketChirp()
            withAnimation(.spring(response: 0.65, dampingFraction: 0.72)) {
                ticketOffset = 0
                ticketRotation = 0
                ticketOpacity = 1
            }
        }
    }
}

#Preview {
    TicketSuccessView(confirmationCode: "HRH-9X21-K4", title: "Steak House", onDone: {})
        .background(AppColors.background)
}
