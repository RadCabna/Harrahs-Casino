import Foundation

@Observable
final class EventsViewModel {
    private let bookingsViewModel: MyBookingsViewModel
    private let profileViewModel: ProfileViewModel
    private var registeredEventIDs: Set<String>

    var showRegistrationTicket = false
    var registrationConfirmationCode = ""
    var registrationTicketTitle = ""

    let events: [TournamentEvent] = [
        TournamentEvent(
            id: "1",
            title: "Harrah's High Roller Poker Night",
            eventType: "Poker Tournament",
            scheduleText: "Fri, 7:00 PM",
            entryFee: "$500 + 500 Tier Credits",
            prizeDescription: "Prize Pool: $50,000",
            registrationStatus: .registrationOpen,
            bannerImageName: "event_1",
            gameIconName: "iconPoker",
            detailDescription: "Texas Hold'em tournament with escalating blinds and professional dealers.",
            rules: ["Buy-in required at registration", "Late entry until level 4", "Harrah's house rules apply"]
        ),
        TournamentEvent(
            id: "2",
            title: "Midnight Slots Marathon",
            eventType: "Slots Marathon",
            scheduleText: "Sat, 12:00 AM",
            entryFee: "Free for Diamond+",
            prizeDescription: "Prizes: Free spins, cash up to $5,000, merch",
            registrationStatus: .waitlist,
            bannerImageName: "event_2",
            gameIconName: nil,
            detailDescription: "All-night slot session with hourly prize drops and leaderboard rewards.",
            rules: ["Diamond tier or above for free entry", "Points earned per spin", "Prizes distributed hourly"]
        ),
        TournamentEvent(
            id: "3",
            title: "Blackjack Blitz Championship",
            eventType: "Blackjack Tournament",
            scheduleText: "Sun, 2:00 PM",
            entryFee: "$200 + 200 Tier Credits",
            prizeDescription: "Prize Pool: $25,000 + dinner with dealer",
            registrationStatus: .spotsRemaining(12),
            bannerImageName: "event_3",
            gameIconName: "iconBlackjack",
            detailDescription: "Fast-paced blackjack rounds with elimination brackets.",
            rules: ["Maximum 64 players", "Standard blackjack rules", "Top 8 receive prizes"]
        ),
        TournamentEvent(
            id: "4",
            title: "VIP Roulette & Champagne Evening",
            eventType: "Exclusive Event",
            scheduleText: "Sat, 9:00 PM",
            entryFee: "Seven Stars Only",
            prizeDescription: "Private room, personal dealer, champagne",
            registrationStatus: .inviteOnly,
            bannerImageName: "event_4",
            gameIconName: "iconRoulette",
            detailDescription: "An invitation-only evening in the private high-limit roulette salon.",
            rules: ["Seven Stars members only", "Formal attire recommended", "RSVP required"]
        ),
        TournamentEvent(
            id: "5",
            title: "Summer Party",
            eventType: "Themed Party",
            scheduleText: "Jul 31, 10:00 PM",
            entryFee: "$100 (includes one drink)",
            prizeDescription: "Live music, fireworks, win bonuses",
            registrationStatus: .preRegistration,
            bannerImageName: "event_5",
            gameIconName: nil,
            detailDescription: "Poolside celebration with live DJ, fireworks, and bonus casino credits.",
            rules: ["Includes one welcome drink", "Outdoor and indoor access", "Bonus credits for winners"]
        )
    ]

    init(
        bookingsViewModel: MyBookingsViewModel,
        profileViewModel: ProfileViewModel
    ) {
        self.bookingsViewModel = bookingsViewModel
        self.profileViewModel = profileViewModel
        registeredEventIDs = Set(UserPersistence.load().registeredEventIDs)
    }

    func isRegistered(for eventID: String) -> Bool {
        registeredEventIDs.contains(eventID)
    }

    func displayRegistrationStatus(for event: TournamentEvent) -> EventRegistrationStatus {
        if isRegistered(for: event.id) {
            return .registered
        }
        return event.registrationStatus
    }

    func register(for event: TournamentEvent) {
        guard event.registrationStatus == .registrationOpen else { return }
        guard !registeredEventIDs.contains(event.id) else { return }

        let bookingNumber = "EVT-\(event.id)-\(Int.random(in: 100000...999999))"
        let confirmationCode = "HRH-\(String(UUID().uuidString.prefix(8)).uppercased())"
        let booking = event.makeEventBooking(
            confirmationCode: confirmationCode,
            bookingNumber: bookingNumber
        )

        bookingsViewModel.addBooking(booking)
        profileViewModel.recordBookingCreated()

        registeredEventIDs.insert(event.id)
        UserPersistence.update { state in
            if !state.registeredEventIDs.contains(event.id) {
                state.registeredEventIDs.append(event.id)
            }
        }

        registrationConfirmationCode = confirmationCode
        registrationTicketTitle = "\(event.title) · \(bookingNumber)"
        showRegistrationTicket = true
        AppHaptics.success()
        AppSounds.ticketChirp()
    }

    func dismissRegistrationTicket() {
        showRegistrationTicket = false
        registrationConfirmationCode = ""
        registrationTicketTitle = ""
    }
}
