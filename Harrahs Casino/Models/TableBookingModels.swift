import Foundation

enum GameType: String, CaseIterable, Identifiable, Codable {
    case poker
    case blackjack
    case roulette
    case craps
    case baccarat

    var id: String { rawValue }

    var title: String {
        switch self {
        case .poker: "Poker"
        case .blackjack: "Blackjack"
        case .roulette: "Roulette"
        case .craps: "Craps"
        case .baccarat: "Baccarat"
        }
    }

    var iconImageName: String {
        switch self {
        case .poker: "iconPoker"
        case .blackjack: "iconBlackjack"
        case .roulette: "iconRoulette"
        case .craps: "iconCraps"
        case .baccarat: "iconBaccara"
        }
    }
}

enum BetLimit: String, CaseIterable, Identifiable, Codable {
    case low
    case medium
    case high
    case vip

    var id: String { rawValue }

    var title: String {
        switch self {
        case .low: "$10–25"
        case .medium: "$25–100"
        case .high: "$100–500"
        case .vip: "$500+"
        }
    }
}

enum BookingTimeSlot: String, CaseIterable, Identifiable {
    case now
    case evening
    case night
    case tomorrow

    var id: String { rawValue }

    var shortTitle: String {
        switch self {
        case .now: "Now"
        case .evening: "Evening"
        case .night: "Night"
        case .tomorrow: "Choose"
        }
    }
}

enum PlayerCountOption: String, CaseIterable, Identifiable {
    case solo
    case smallGroup
    case largeGroup

    var id: String { rawValue }

    var title: String {
        switch self {
        case .solo: "1"
        case .smallGroup: "2–4"
        case .largeGroup: "5+"
        }
    }
}

enum BookingListTab: String, CaseIterable, Identifiable, Codable {
    case active
    case upcoming
    case history

    var id: String { rawValue }

    var title: String {
        switch self {
        case .active: "Active"
        case .upcoming: "Upcoming"
        case .history: "History"
        }
    }
}

enum TableBookingStatus: String, Hashable, Codable {
    case confirmed
    case pending
    case cancelled
    case completed

    var title: String {
        switch self {
        case .confirmed: "Confirmed"
        case .pending: "Pending"
        case .cancelled: "Cancelled"
        case .completed: "Completed"
        }
    }
}

struct TableBooking: Identifiable, Hashable, Codable {
    let id: String
    let gameType: GameType
    let betLimit: BetLimit
    let scheduleText: String
    let status: TableBookingStatus
    let confirmationCode: String
    let listTab: BookingListTab
    let isPremium: Bool
    var ticketTitle: String? = nil
    var eventEntryFee: String? = nil

    var isEventTicket: Bool {
        ticketTitle != nil
    }
}
