import WidgetKit
import ElprisetShared

struct PriceEntry: TimelineEntry {
    let date: Date
    let currentPrice: Decimal
    let priceLevel: String
    let priceZone: String
    let todayPrices: [WidgetPrice]
    let cheapestTime: String?
    let cheapestPrice: Decimal?
    let mostExpensiveTime: String?
    let mostExpensivePrice: Decimal?
    let showTotalCost: Bool

    struct WidgetPrice: Codable {
        let price: Double
        let timeStart: Date
        let level: String
    }

    static var placeholder: PriceEntry {
        PriceEntry(
            date: .now,
            currentPrice: 1.87,
            priceLevel: PriceLevel.normal.rawValue,
            priceZone: PriceZone.SE3.rawValue,
            todayPrices: [],
            cheapestTime: "14:15",
            cheapestPrice: 0.89,
            mostExpensiveTime: "18:00",
            mostExpensivePrice: 3.42,
            showTotalCost: true
        )
    }
}
