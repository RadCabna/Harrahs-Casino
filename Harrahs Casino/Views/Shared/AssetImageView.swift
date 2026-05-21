import SwiftUI
import UIKit

struct AssetImageView: View {
    let name: String
    var placeholderSystemName: String = "photo"
    var height: CGFloat?

    var body: some View {
        Group {
            if UIImage(named: name) != nil {
                Image(name)
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    LinearGradient(
                        colors: [AppColors.brandRed.opacity(0.4), AppColors.background],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    Image(systemName: placeholderSystemName)
                        .font(.system(size: screenHeight * 0.05))
                        .foregroundStyle(AppColors.white.opacity(0.35))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .clipped()
    }
}

#Preview {
    AssetImageView(name: "event_banner_poker", height: ScreenLayout.scaled(0.19))
        .padding()
        .background(AppColors.background)
}
