import Foundation

@Observable
final class CreateBookingViewModel {
    private let bookingsViewModel: MyBookingsViewModel
    private let profileViewModel: ProfileViewModel

    var gameType: GameType = .blackjack
    var betLimit: BetLimit = .medium
    var timeSlot: BookingTimeSlot = .now
    var tomorrowTime = Date().addingTimeInterval(86400)
    var playerCount: PlayerCountOption = .solo
    var specialNotes = ""
    var showTicketSuccess = false
    var generatedConfirmationCode = ""
    var generatedBookingNumber = ""

    let maxNotesLength = 140

    init(bookingsViewModel: MyBookingsViewModel, profileViewModel: ProfileViewModel) {
        self.bookingsViewModel = bookingsViewModel
        self.profileViewModel = profileViewModel
    }

    var notesCountText: String {
        "\(specialNotes.count)/\(maxNotesLength)"
    }

    var canCreateBooking: Bool {
        specialNotes.count <= maxNotesLength
    }

    func createBooking() {
        guard canCreateBooking else { return }
        generatedBookingNumber = "BK-\(Int.random(in: 100000...999999))"
        generatedConfirmationCode = "HRH-\(String(UUID().uuidString.prefix(8)).uppercased())"

        let listTab: BookingListTab = timeSlot == .tomorrow ? .upcoming : .active
        let booking = TableBooking(
            id: generatedBookingNumber,
            gameType: gameType,
            betLimit: betLimit,
            scheduleText: scheduleText,
            status: listTab == .upcoming ? .pending : .confirmed,
            confirmationCode: generatedConfirmationCode,
            listTab: listTab,
            isPremium: betLimit == .vip
        )
        bookingsViewModel.addBooking(booking)
        profileViewModel.recordBookingCreated()

        showTicketSuccess = true
        AppHaptics.success()
        AppSounds.ticketChirp()
    }

    private var scheduleText: String {
        switch timeSlot {
        case .now:
            "Today, starting now"
        case .evening:
            "Today, evening"
        case .night:
            "Today, night"
        case .tomorrow:
            Self.scheduleFormatter.string(from: tomorrowTime)
        }
    }

    private static let scheduleFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    func reset() {
        gameType = .blackjack
        betLimit = .medium
        timeSlot = .now
        playerCount = .solo
        specialNotes = ""
        showTicketSuccess = false
        generatedConfirmationCode = ""
        generatedBookingNumber = ""
    }
}
