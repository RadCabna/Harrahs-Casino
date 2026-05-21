import SwiftUI
import UIKit

struct AvatarView: View {
    let image: UIImage?
    var size: CGFloat?

    private var avatarSize: CGFloat {
        size ?? screenHeight * 0.104
    }

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(AppColors.brandGold.opacity(0.85))
                    .padding(avatarSize * 0.12)
                    .background(AppColors.fieldBackground)
            }
        }
        .frame(width: avatarSize, height: avatarSize)
        .clipShape(Circle())
        .overlay(Circle().stroke(AppColors.glassGoldStroke, lineWidth: screenHeight * 0.0024))
    }
}

#Preview {
    AvatarView(image: nil)
        .padding()
        .background(AppColors.background)
}
