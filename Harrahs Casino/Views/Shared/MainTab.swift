import SwiftUI

enum MainTab: Int, CaseIterable, Identifiable {
    case profile
    case createBooking
    case events
    case myBookings
    case map

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .profile: "Profile"
        case .createBooking: "Book"
        case .events: "Events"
        case .myBookings: "Bookings"
        case .map: "Map"
        }
    }

    var systemImage: String {
        switch self {
        case .profile: "person.fill"
        case .createBooking: "dice.fill"
        case .events: "calendar"
        case .myBookings: "ticket.fill"
        case .map: "map.fill"
        }
    }
}
