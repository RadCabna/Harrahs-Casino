import SwiftUI
import UIKit

@Observable
final class ProfileViewModel {
    private let experiencePerBooking = 1000

    var userName: String
    var tier: LoyaltyTier
    var tierCredits: Int
    var bookingsTowardNextTier: Int
    var progressToNextTier: Double = 0
    var bookingsUntilUpgrade: Int = 0
    var avatarImage: UIImage?
    var email: String
    var phone: String
    var showLoyaltyUpgrade = false

    var upgradeTip: String {
        guard let next = tier.nextTier, let required = tier.bookingsRequiredForNextTier else {
            return "You have reached the highest tier"
        }
        let remaining = max(0, required - bookingsTowardNextTier)
        if remaining == 0 {
            return "Tier upgrade available on your next booking"
        }
        let tableWord = remaining == 1 ? "table" : "tables"
        return "Book \(remaining) more \(tableWord) to reach \(next.title)"
    }

    var tierProgressTitle: String {
        guard let next = tier.nextTier else {
            return "Tier Progress"
        }
        return "Progress to \(next.title)"
    }

    init() {
        let state = UserPersistence.load()
        userName = state.userName
        tier = state.loyaltyTier
        tierCredits = state.tierCredits
        bookingsTowardNextTier = state.bookingsTowardNextTier
        email = state.email
        phone = state.phone
        if let data = state.avatarJPEGData {
            avatarImage = UIImage(data: data)
        } else {
            avatarImage = nil
        }
        refreshProgressMetrics()
    }

    func recordBookingCreated() {
        tierCredits += experiencePerBooking

        if let required = tier.bookingsRequiredForNextTier, let next = tier.nextTier {
            bookingsTowardNextTier += 1
            if bookingsTowardNextTier >= required {
                tier = next
                bookingsTowardNextTier = 0
                showLoyaltyUpgrade = true
                AppHaptics.success()
            }
        }

        refreshProgressMetrics()
        persist()
    }

    func persist() {
        UserPersistence.update { state in
            state.userName = userName
            state.loyaltyTierRaw = tier.rawValue
            state.tierCredits = tierCredits
            state.bookingsTowardNextTier = bookingsTowardNextTier
            state.email = email
            state.phone = phone
            state.avatarJPEGData = avatarImage?.jpegData(compressionQuality: 0.85)
        }
    }

    func simulateTierUpgrade() {
        guard let next = tier.nextTier else { return }
        tier = next
        bookingsTowardNextTier = 0
        showLoyaltyUpgrade = true
        refreshProgressMetrics()
        persist()
    }

    private func refreshProgressMetrics() {
        guard let required = tier.bookingsRequiredForNextTier else {
            progressToNextTier = 1
            bookingsUntilUpgrade = 0
            return
        }
        progressToNextTier = Double(bookingsTowardNextTier) / Double(required)
        bookingsUntilUpgrade = max(0, required - bookingsTowardNextTier)
    }
}
