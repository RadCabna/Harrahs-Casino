import SwiftUI

struct GradientBackgroundView: View {
    var parallaxOffset: CGFloat = 0

    var body: some View {
        ZStack {
            Image("appBG_1")
                .resizable()
                .scaledToFill()
                .offset(x: parallaxOffset * 0.08, y: parallaxOffset * 0.04)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()

            LinearGradient(
                colors: [
                    AppColors.background.opacity(0.35),
                    AppColors.background.opacity(0.55)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GradientBackgroundView()
}
