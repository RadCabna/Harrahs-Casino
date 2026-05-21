import SwiftUI

struct LoyaltyProgressBar: View {
    let progress: Double

    private var clampedProgress: Double {
        min(max(progress, 0), 1)
    }

    var body: some View {
        GeometryReader { proxy in
            let barWidth = proxy.size.width
            let barHeight = proxy.size.height
            let cornerRadius = barHeight * 0.5
            let hiddenOffset = barWidth * (1 - clampedProgress)

            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(AppColors.fieldBackground.opacity(0.45))
                .overlay {
                    Image("progressLineBack")
                        .resizable()
                        .scaledToFill()
                        .frame(width: barWidth, height: barHeight)
                        .offset(x: -hiddenOffset)
                }
                .frame(width: barWidth, height: barHeight)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .frame(height: screenHeight * 0.022)
    }
}

#Preview {
    VStack(spacing: ScreenLayout.scaled(0.02)) {
        LoyaltyProgressBar(progress: 0)
        LoyaltyProgressBar(progress: 0.42)
        LoyaltyProgressBar(progress: 0.78)
        LoyaltyProgressBar(progress: 1)
    }
    .padding(.horizontal, ScreenLayout.horizontalPadding)
    .background(AppColors.background)
}
