import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isEnabled: Bool = true

    @State private var isPressed = false

    var body: some View {
        Button {
            AppHaptics.medium()
            action()
        } label: {
            Text(title)
                .font(AppTypography.body(0.0201, weight: .semibold))
                .foregroundStyle(AppColors.white)
                .frame(maxWidth: .infinity)
                .frame(height: screenHeight * 0.058)
                .background(
                    Group {
                        if isEnabled {
                            AppColors.primaryButtonGradient
                        } else {
                            LinearGradient(
                                colors: [AppColors.fieldBackground, AppColors.fieldBackground],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.014))
                .shadow(
                    color: isEnabled ? AppColors.brandRed.opacity(0.45) : .clear,
                    radius: isPressed ? screenHeight * 0.005 : screenHeight * 0.012,
                    y: isPressed ? screenHeight * 0.002 : screenHeight * 0.007
                )
                .scaleEffect(isPressed ? 0.97 : 1)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if isEnabled { isPressed = true }
                }
                .onEnded { _ in isPressed = false }
        )
        .animation(.easeOut(duration: 0.15), value: isPressed)
        .accessibilityLabel(title)
    }
}

#Preview {
    PrimaryButton(title: "Reserve Now", action: {})
        .padding()
        .background(AppColors.background)
}
