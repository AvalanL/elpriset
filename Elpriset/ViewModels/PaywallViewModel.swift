import Foundation

enum SubscriptionTier: String, CaseIterable, Identifiable {
    case weekly
    case monthly
    case annual
    case lifetime

    var id: String { rawValue }

    var label: String {
        switch self {
        case .weekly: return "Vecka"
        case .monthly: return "Månad"
        case .annual: return "År"
        case .lifetime: return "Livstid"
        }
    }

    var price: String {
        switch self {
        case .weekly: return "19 kr/v"
        case .monthly: return "29 kr/mån"
        case .annual: return "149 kr/år"
        case .lifetime: return "349 kr"
        }
    }

    var subtitle: String? {
        switch self {
        case .annual: return "Bara 12 kr/mån"
        case .lifetime: return "Engångsköp"
        default: return nil
        }
    }

    var isBestValue: Bool {
        self == .annual
    }
}

@MainActor @Observable
final class PaywallViewModel {
    var selectedTier: SubscriptionTier = .annual
    var isPurchasing = false

    let features = [
        "Totalkostnad per kWh",
        "Alla widgets",
        "Apple Watch",
        "Imorgons priser",
        "Smarta tips",
        "Prishistorik"
    ]

    func purchase() async {
        isPurchasing = true
        // Stubbed — will integrate StoreKit 2 later
        try? await Task.sleep(for: .seconds(1))
        isPurchasing = false
    }

    func restorePurchases() async {
        // Stubbed
    }
}
