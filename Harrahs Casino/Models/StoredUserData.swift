import Foundation

struct StoredUserData: Codable {
    var tierCredits: Int = 0
    var loyaltyTierRaw: String = LoyaltyTier.gold.rawValue
    var bookingsTowardNextTier: Int = 0
    var userName: String = "Guest"
    var email: String = ""
    var phone: String = ""
    var avatarJPEGData: Data?
    var bookings: [TableBooking] = []
    var registeredEventIDs: [String] = []

    var loyaltyTier: LoyaltyTier {
        LoyaltyTier(rawValue: loyaltyTierRaw) ?? .gold
    }
}
