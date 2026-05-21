import Foundation

@Observable
final class MyBookingsViewModel {
    var selectedTab: BookingListTab = .active
    private(set) var allBookings: [TableBooking]

    var filteredBookings: [TableBooking] {
        allBookings.filter { $0.listTab == selectedTab }
    }

    init() {
        allBookings = UserPersistence.load().bookings
    }

    func addBooking(_ booking: TableBooking) {
        allBookings.insert(booking, at: 0)
        persist()
    }

    func cancelBooking(id: String) {
        guard let index = allBookings.firstIndex(where: { $0.id == id }) else { return }
        let booking = allBookings[index]
        allBookings[index] = TableBooking(
            id: booking.id,
            gameType: booking.gameType,
            betLimit: booking.betLimit,
            scheduleText: booking.scheduleText,
            status: .cancelled,
            confirmationCode: booking.confirmationCode,
            listTab: .history,
            isPremium: booking.isPremium,
            ticketTitle: booking.ticketTitle,
            eventEntryFee: booking.eventEntryFee
        )
        AppHaptics.warning()
        persist()
    }

    private func persist() {
        UserPersistence.update { state in
            state.bookings = allBookings
        }
    }
}
