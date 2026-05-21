import SwiftUI

enum LoyaltyTier: String, CaseIterable, Identifiable, Codable {
    case gold
    case platinum
    case diamond
    case sevenStars

    var id: String { rawValue }

    var title: String {
        switch self {
        case .gold: "Gold"
        case .platinum: "Platinum"
        case .diamond: "Diamond"
        case .sevenStars: "Seven Stars"
        }
    }

    var statusImageName: String {
        switch self {
        case .gold: "goldStatus"
        case .platinum: "platinumStatus"
        case .diamond: "diamondStatus"
        case .sevenStars: "ssStatus"
        }
    }

    var displayName: String { title }

    var nextTier: LoyaltyTier? {
        switch self {
        case .gold: .platinum
        case .platinum: .diamond
        case .diamond: .sevenStars
        case .sevenStars: nil
        }
    }

    var bookingsRequiredForNextTier: Int? {
        switch self {
        case .gold: 5
        case .platinum: 10
        case .diamond: 15
        case .sevenStars: nil
        }
    }
}
