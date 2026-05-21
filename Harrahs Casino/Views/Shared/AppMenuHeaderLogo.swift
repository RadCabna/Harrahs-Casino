import SwiftUI

struct AppMenuHeaderLogo: View {
    var body: some View {
        AppHeaderLogo(
            width: ScreenLayout.width * ScreenLayout.contentWidthRatio,
            height: screenHeight * 0.1
        )
        .frame(maxWidth: .infinity)
        .padding(.top, screenHeight * 0.01)
        .padding(.bottom, screenHeight * 0.014)
    }
}

#Preview {
    AppMenuHeaderLogo()
        .padding(.horizontal, ScreenLayout.horizontalPadding)
        .background(AppColors.background)
}
