import SwiftUI

enum AvailabilityStatus: String, CaseIterable, Identifiable {
    case available
    case pending
    case occupied

    var id: String { rawValue }

    var title: String {
        switch self {
        case .available: "Available"
        case .pending: "Pending"
        case .occupied: "Occupied"
        }
    }

    var color: Color {
        switch self {
        case .available: AppColors.available
        case .pending: AppColors.pending
        case .occupied: AppColors.occupied
        }
    }

    var systemImage: String {
        switch self {
        case .available: "checkmark.circle.fill"
        case .pending: "clock.fill"
        case .occupied: "xmark.circle.fill"
        }
    }
}
