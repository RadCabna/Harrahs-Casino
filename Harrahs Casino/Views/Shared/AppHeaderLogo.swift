import SwiftUI

struct AppHeaderLogo: View {
    var width: CGFloat?
    var height: CGFloat?

    private var logoWidth: CGFloat {
        width ?? ScreenLayout.width * 0.72
    }

    private var logoMaxHeight: CGFloat {
        height ?? screenHeight * 0.055
    }

    var body: some View {
        Image("mainLogo")
            .resizable()
            .scaledToFit()
            .frame(width: logoWidth)
            .frame(maxHeight: logoMaxHeight)
            .accessibilityLabel("Harrah's Casino")
    }
}

#Preview {
    AppHeaderLogo()
        .padding()
        .background(AppColors.background)
}
