import SwiftUI

struct AuthenticationView: View {
    @Bindable var viewModel: AuthenticationViewModel
    var onAuthenticated: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: screenHeight * 0.028) {
                Image("autorisationLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: ScreenLayout.width * 0.72)
                    .frame(maxHeight: screenHeight * 0.2)
                    .padding(.top, screenHeight * 0.04)

                Text("Authentication")
                    .font(AppTypography.display(0.032))
                    .foregroundStyle(AppColors.textPrimary)

                VStack(spacing: screenHeight * 0.02) {
                    AppTextField(
                        title: "Email",
                        placeholder: "Email",
                        text: $viewModel.email,
                        keyboardType: .emailAddress,
                        textContentType: .emailAddress,
                        errorMessage: viewModel.emailError,
                        isValid: viewModel.emailError == nil
                    )
                    .onChange(of: viewModel.email) { _, _ in
                        viewModel.emailError = nil
                        viewModel.credentialsError = nil
                    }

                    AppTextField(
                        title: "Password",
                        placeholder: "Password",
                        text: $viewModel.password,
                        isSecure: true,
                        textContentType: .password,
                        errorMessage: viewModel.passwordError,
                        isValid: viewModel.passwordError == nil
                    )
                    .onChange(of: viewModel.password) { _, _ in
                        viewModel.passwordError = nil
                        viewModel.credentialsError = nil
                    }

                    if let credentialsError = viewModel.credentialsError {
                        Text(credentialsError)
                            .font(AppTypography.body(0.0166))
                            .foregroundStyle(AppColors.destructive)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                PrimaryButton(title: "Sign In", action: attemptSignIn)
            }
            .padding(.horizontal, contentHorizontalPadding)
            .padding(.vertical, screenHeight * 0.04)
        }
        .scrollIndicators(.hidden)
        .appScrollViewSupport()
        .background {
            AuthBackgroundView()
        }
    }

    private func attemptSignIn() {
        if viewModel.signIn() {
            onAuthenticated()
        }
    }
}

#Preview {
    AuthenticationView(viewModel: AuthenticationViewModel(), onAuthenticated: {})
}
