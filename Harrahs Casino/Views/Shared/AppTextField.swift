import SwiftUI

struct AppTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType?
    var autocapitalization: TextInputAutocapitalization = .never
    var errorMessage: String?
    var isValid: Bool = true
    var accentBorderColor: Color?

    private var borderColor: Color {
        if let errorMessage, !errorMessage.isEmpty { return AppColors.destructive }
        if !isValid { return AppColors.pending }
        if let accentBorderColor { return accentBorderColor }
        if !text.isEmpty { return AppColors.fieldBorderFocused }
        return AppColors.fieldBorder
    }

    var body: some View {
        VStack(alignment: .leading, spacing: screenHeight * 0.008) {
            Text(title)
                .font(AppTypography.body(0.0166, weight: .medium))
                .foregroundStyle(AppColors.textSecondary)

            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(AppTypography.body(0.019))
                        .foregroundStyle(AppColors.placeholder)
                        .allowsHitTesting(false)
                }

                Group {
                    if isSecure {
                        SecureField("", text: $text)
                    } else {
                        TextField("", text: $text)
                    }
                }
                .font(AppTypography.body(0.019))
                .foregroundStyle(AppColors.textPrimary)
                .textInputAutocapitalization(autocapitalization)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .tint(AppColors.brandGold)
            }
            .padding(.horizontal, screenHeight * 0.04)
            .frame(height: screenHeight * 0.056)
            .background(AppColors.fieldBackground)
            .overlay(
                RoundedRectangle(cornerRadius: screenHeight * 0.012)
                    .stroke(borderColor, lineWidth: screenHeight * 0.0018)
            )
            .clipShape(RoundedRectangle(cornerRadius: screenHeight * 0.012))

            if let errorMessage, !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(AppTypography.body(0.0142))
                    .foregroundStyle(AppColors.destructive)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var name = ""
        var body: some View {
            AppTextField(
                title: "Full Name",
                placeholder: "Jane Doe",
                text: $name,
                errorMessage: name.isEmpty ? "Name is required" : nil,
                isValid: !name.isEmpty
            )
            .padding()
            .background(AppColors.background)
        }
    }
    return PreviewWrapper()
}
