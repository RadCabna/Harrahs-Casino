import Foundation

enum AuthCredentials {
    static let email = "harrahs@casino.com"
    static let password = "123456"
}

@Observable
final class AuthenticationViewModel {
    var email = ""
    var password = ""
    var emailError: String?
    var passwordError: String?
    var credentialsError: String?

    func signIn() -> Bool {
        emailError = nil
        passwordError = nil
        credentialsError = nil

        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        if !Self.isValidEmail(trimmedEmail) {
            emailError = "Enter a valid email address"
        }
        if password.count < 5 {
            passwordError = "Password must be at least 5 characters"
        }

        guard emailError == nil, passwordError == nil else {
            AppHaptics.warning()
            return false
        }

        guard trimmedEmail.lowercased() == AuthCredentials.email,
              password == AuthCredentials.password else {
            credentialsError = "Invalid email or password"
            AppHaptics.warning()
            return false
        }

        AuthSession.markSignedIn()
        AppHaptics.success()
        return true
    }

    private static func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
}
