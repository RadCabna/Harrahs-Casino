import SwiftUI

struct TicketSuccessView: View {
    let confirmationCode: String
    let title: String
    var onDone: () -> Void

    @State private var ticketOffset: CGFloat = ScreenLayout.scaled(0.3)
    @State private var ticketRotation: Double = -8
    @State private var ticketOpacity: Double = 0

    var body: some View {
        ScrollView {
            VStack(spacing: screenHeight * 0.018) {
                Text("Reservation Confirmed")
                    .font(AppTypography.display(0.026))
                    .foregroundStyle(AppColors.textPrimary)

                ticketCard
                    .offset(y: ticketOffset)
                    .rotationEffect(.degrees(ticketRotation))
                    .opacity(ticketOpacity)

                PrimaryButton(title: "Done", action: onDone)
            }
            .padding(.horizontal, contentHorizontalPadding)
            .padding(.top, screenHeight * 0.02)
            .padding(.bottom, screenHeight * 0.11)
        }
        .scrollIndicators(.hidden)
        .appScrollViewSupport()
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

    private var ticketCard: some View {
        VStack(spacing: screenHeight * 0.014) {
            Image(systemName: "ticket.fill")
                .font(.system(size: screenHeight * 0.038))
                .foregroundStyle(AppColors.brandGold)

            Text(title)
                .font(AppTypography.accentTitle(0.019))
                .foregroundStyle(AppColors.white)
                .multilineTextAlignment(.center)

            if let qrImage = QRCodeGenerator.image(from: confirmationCode) {
                qrImage
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenHeight * 0.2, height: screenHeight * 0.2)
                    .padding(screenHeight * 0.028)
                    .background(AppColors.white)
                    .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.012))
            }

            Text("Your digital pass")
                .font(AppTypography.body(0.0154, weight: .medium))
                .foregroundStyle(AppColors.textSecondary)

            Text(confirmationCode)
                .font(AppTypography.balance(0.0142))
                .foregroundStyle(AppColors.brandGold)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, screenHeight * 0.032)
        .padding(.horizontal, screenHeight * 0.024)
        .glassCard(isPremium: true)
    }
}

#Preview {
    TicketSuccessView(confirmationCode: "HRH-9X21-K4", title: "Blackjack · BK-123456", onDone: {})
        .background(AppColors.background)
}
