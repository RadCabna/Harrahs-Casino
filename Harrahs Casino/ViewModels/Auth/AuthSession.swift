import Foundation

enum AuthSession {
    private static let signedInKey = "harrahs.user.isSignedIn"

    static var isSignedIn: Bool {
        UserDefaults.standard.bool(forKey: signedInKey)
    }

    static func markSignedIn() {
        UserDefaults.standard.set(true, forKey: signedInKey)
    }

    static func signOut() {
        UserDefaults.standard.set(false, forKey: signedInKey)
        UserPersistence.reset()
    }
}
