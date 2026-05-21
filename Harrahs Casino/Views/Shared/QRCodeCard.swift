import SwiftUI

struct QRCodeCard: View {
    let code: String
    let caption: String

    var body: some View {
        VStack(spacing: screenHeight * 0.016) {
            if let qrImage = QRCodeGenerator.image(from: code) {
                qrImage
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenHeight * 0.28, height: screenHeight * 0.28)
                    .padding(screenHeight * 0.04)
                    .background(AppColors.white)
                    .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.016))
            }

            Text(caption)
                .font(AppTypography.body(0.0166, weight: .medium))
                .foregroundStyle(AppColors.textSecondary)

            Text(code)
                .font(AppTypography.balance(0.0154))
                .foregroundStyle(AppColors.brandGold)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, screenHeight * 0.024)
        .glassCard(isPremium: true)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("QR code for \(caption)")
    }
}

#Preview {
    QRCodeCard(code: "HRH-8F2K-91XQ", caption: "Scan at entrance")
        .padding()
        .background(AppColors.background)
}
