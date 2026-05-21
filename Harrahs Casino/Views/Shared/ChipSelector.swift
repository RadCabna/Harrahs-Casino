import SwiftUI

struct ChipSelector: View {
    let title: String
    let options: [String]
    @Binding var selection: String
    var equalWidth: Bool = false
    var onChange: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: screenHeight * 0.01) {
            Text(title)
                .font(AppTypography.body(0.0166, weight: .medium))
                .foregroundStyle(AppColors.textSecondary)

            if equalWidth {
                HStack(spacing: screenHeight * 0.008) {
                    ForEach(options, id: \.self) { option in
                        chip(option)
                            .frame(maxWidth: .infinity)
                    }
                }
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: screenHeight * 0.01) {
                        ForEach(options, id: \.self) { option in
                            chip(option)
                        }
                    }
                    .padding(.trailing, screenHeight * 0.004)
                }
                .scrollIndicators(.hidden)
            }
        }
    }

    private func chip(_ option: String) -> some View {
        let isSelected = selection == option
        return Button {
            AppHaptics.selection()
            selection = option
            onChange?()
        } label: {
            Text(option)
                .font(AppTypography.body(0.0142, weight: .medium))
                .foregroundStyle(isSelected ? AppColors.white : AppColors.textSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .padding(.horizontal, screenHeight * 0.012)
                .frame(maxWidth: equalWidth ? .infinity : nil)
                .frame(height: screenHeight * 0.044)
                .background(isSelected ? AppColors.brandRed : AppColors.fieldBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: screenHeight * 0.01)
                        .stroke(isSelected ? AppColors.brandRed : AppColors.fieldBorder, lineWidth: screenHeight * 0.0012)
                )
                .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.01))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selected = "$25–100"
        var body: some View {
            ChipSelector(
                title: "Bet Limits",
                options: ["$10–25", "$25–100", "$100–500", "$500+"],
                selection: $selected,
                equalWidth: true
            )
            .padding(.horizontal, ScreenLayout.horizontalPadding)
            .background(AppColors.background)
        }
    }
    return PreviewWrapper()
}
