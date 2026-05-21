import Foundation

extension TournamentEvent {
    var bookingGameType: GameType {
        switch gameIconName {
        case "iconPoker": .poker
        case "iconBlackjack": .blackjack
        case "iconRoulette": .roulette
        case "iconCraps": .craps
        case "iconBaccara": .baccarat
        default: .poker
        }
    }

    var isPremiumEvent: Bool {
        if case .inviteOnly = registrationStatus { return true }
        return entryFee.localizedCaseInsensitiveContains("Seven Stars")
    }

    func makeEventBooking(confirmationCode: String, bookingNumber: String) -> TableBooking {
        TableBooking(
            id: bookingNumber,
            gameType: bookingGameType,
            betLimit: .medium,
            scheduleText: scheduleText,
            status: bookingStatus,
            confirmationCode: confirmationCode,
            listTab: .upcoming,
            isPremium: isPremiumEvent,
            ticketTitle: title,
            eventEntryFee: entryFee
        )
    }

    private var bookingStatus: TableBookingStatus {
        switch registrationStatus {
        case .registrationOpen, .spotsRemaining, .registered: .confirmed
        case .preRegistration, .waitlist: .pending
        case .inviteOnly: .confirmed
        }
    }
}
