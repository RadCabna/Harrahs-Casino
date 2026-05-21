import SwiftUI

enum EventRegistrationStatus: Hashable {
    case registrationOpen
    case waitlist
    case spotsRemaining(Int)
    case inviteOnly
    case preRegistration
    case registered

    var title: String {
        switch self {
        case .registrationOpen: "Registration Open"
        case .waitlist: "Waitlist"
        case .spotsRemaining(let count): "Spots Left: \(count)"
        case .inviteOnly: "Invitation Only"
        case .preRegistration: "Pre-Registration"
        case .registered: "Registered"
        }
    }

    var color: Color {
        switch self {
        case .registrationOpen: AppColors.brandRed
        case .waitlist, .preRegistration: AppColors.pending
        case .spotsRemaining: AppColors.available
        case .inviteOnly: AppColors.textSecondary
        case .registered: AppColors.available
        }
    }

    var canRegister: Bool {
        self == .registrationOpen
    }
}
