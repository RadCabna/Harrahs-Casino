import SwiftUI

struct SegmentedOptionPicker<Option: Identifiable & Hashable>: View where Option.ID == String {
    let title: String
    let options: [Option]
    @Binding var selection: Option
    let label: (Option) -> String

    var body: some View {
        VStack(alignment: .leading, spacing: screenHeight * 0.01) {
            Text(title)
                .font(AppTypography.body(0.0166, weight: .medium))
                .foregroundStyle(AppColors.textSecondary)

            HStack(spacing: screenHeight * 0.008) {
                ForEach(options) { option in
                    segmentButton(option)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private func segmentButton(_ option: Option) -> some View {
        let isSelected = selection.id == option.id
        return Button {
            AppHaptics.selection()
            selection = option
        } label: {
            Text(label(option))
                .font(AppTypography.body(0.013, weight: .medium))
                .foregroundStyle(isSelected ? AppColors.white : AppColors.textSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: .infinity)
                .frame(height: screenHeight * 0.044)
                .background(isSelected ? AppColors.brandRed : AppColors.fieldBackground)
                .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.01))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var slot = BookingTimeSlot.now
        var body: some View {
            SegmentedOptionPicker(
                title: "Time",
                options: BookingTimeSlot.allCases,
                selection: $slot,
                label: \.shortTitle
            )
            .padding(.horizontal, ScreenLayout.horizontalPadding)
            .background(AppColors.background)
        }
    }
    return PreviewWrapper()
}
