import Foundation

struct TournamentEvent: Identifiable, Hashable {
    let id: String
    let title: String
    let eventType: String
    let scheduleText: String
    let entryFee: String
    let prizeDescription: String
    let registrationStatus: EventRegistrationStatus
    let bannerImageName: String
    let gameIconName: String?
    let detailDescription: String
    let rules: [String]
}
