import SwiftUI

struct AuthBackgroundView: View {
    var body: some View {
        ZStack {
            Image("appBG_2")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()

            LinearGradient(
                colors: [
                    AppColors.background.opacity(0.25),
                    AppColors.background.opacity(0.5)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AuthBackgroundView()
}
