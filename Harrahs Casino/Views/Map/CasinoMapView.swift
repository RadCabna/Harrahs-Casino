import SwiftUI

struct CasinoMapView: View {
    private let mapImageName = "map"
    private let maxZoomMultiplier: CGFloat = 6

    @State private var zoomResetTrigger = 0

    var body: some View {
        ScrollView {
            VStack(spacing: screenHeight * 0.012) {
                AppMenuHeaderLogo()

                ZoomableMapImageView(
                    imageName: mapImageName,
                    maxZoomMultiplier: maxZoomMultiplier,
                    resetTrigger: zoomResetTrigger
                )
                .frame(height: screenHeight * 0.72)
                .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.012))

                Button("Reset Zoom") {
                    AppHaptics.light()
                    zoomResetTrigger += 1
                }
                .font(AppTypography.body(0.0166, weight: .medium))
                .foregroundStyle(AppColors.brandGold)
                .frame(maxWidth: .infinity, minHeight: screenHeight * 0.052)
            }
            .padding(.horizontal, contentHorizontalPadding)
            .padding(.bottom, screenHeight * 0.02)
        }
        .scrollIndicators(.hidden)
        .appScrollViewSupport()
        .appScreenBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        CasinoMapView()
    }
}
