import SwiftUI

struct BookingsTabPicker: View {
    @Binding var selectedTab: BookingListTab

    var body: some View {
        HStack(spacing: screenHeight * 0.02) {
            ForEach(BookingListTab.allCases) { tab in
                Button {
                    AppHaptics.selection()
                    selectedTab = tab
                } label: {
                    Text(tab.title)
                        .font(AppTypography.body(0.0166, weight: .semibold))
                        .foregroundStyle(selectedTab == tab ? AppColors.white : AppColors.textSecondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: screenHeight * 0.044)
                        .background(selectedTab == tab ? AppColors.brandRed : AppColors.fieldBackground)
                        .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.01))
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var tab = BookingListTab.active
        var body: some View {
            BookingsTabPicker(selectedTab: $tab)
                .padding()
                .background(AppColors.background)
        }
    }
    return PreviewWrapper()
}
