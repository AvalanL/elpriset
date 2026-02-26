import Foundation
import ElprisetShared

enum CostCalculator {
    static func totalPrices(
        from spots: [SpotPrice],
        gridFee: Decimal,
        includeVAT: Bool = true,
        includeGridFee: Bool = true
    ) -> [TotalPrice] {
        spots.map { spot in
            TotalPrice(
                spotPrice: spot.sekPerKwh,
                gridFee: includeGridFee ? gridFee : 0,
                vatMultiplier: includeVAT ? ElectricityConstants.vatMultiplier : 1,
                timeStart: spot.timeStart,
                timeEnd: spot.timeEnd
            )
        }
    }

    static func currentPrice(from prices: [TotalPrice], at date: Date = .now) -> TotalPrice? {
        prices.first { $0.timeStart <= date && $0.timeEnd > date }
    }

    static func cheapestRemaining(from prices: [TotalPrice], after date: Date = .now) -> TotalPrice? {
        prices.filter { $0.timeStart >= date }.min(by: { $0.total < $1.total })
    }

    static func mostExpensiveRemaining(from prices: [TotalPrice], after date: Date = .now) -> TotalPrice? {
        prices.filter { $0.timeStart >= date }.max(by: { $0.total < $1.total })
    }

    static func averagePrice(from prices: [TotalPrice]) -> Decimal? {
        guard !prices.isEmpty else { return nil }
        let sum = prices.reduce(Decimal.zero) { $0 + $1.total }
        return sum / Decimal(prices.count)
    }

    // MARK: - Smart Tips

    struct SmartTip: Identifiable {
        let id = UUID()
        let icon: String
        let text: String
        let savings: Decimal?
    }

    static func generateTips(
        currentPrice: TotalPrice?,
        cheapest: TotalPrice?,
        expensive: TotalPrice?
    ) -> [SmartTip] {
        var tips: [SmartTip] = []

        if let cheapest {
            let timeStr = DateFormatters.timeShort.string(from: cheapest.timeStart)
            let priceStr = PriceFormatter.formatSEK(cheapest.total)
            tips.append(SmartTip(
                icon: "bolt.fill",
                text: "Billigaste kvarten kvar idag: \(timeStr) (\(priceStr) SEK/kWh)",
                savings: nil
            ))
        }

        if let currentPrice, let cheapest {
            let saving = (currentPrice.total - cheapest.total)
            if saving > 0.1 {
                let timeStr = DateFormatters.timeShort.string(from: cheapest.timeStart)
                let savingStr = PriceFormatter.formatSEK(saving * 2) // ~2kWh for a dishwasher cycle
                tips.append(SmartTip(
                    icon: "dishwasher.fill",
                    text: "Bästa tid för disk: \(timeStr) (spara ~\(savingStr) SEK)",
                    savings: saving * 2
                ))
            }
        }

        if let expensive {
            let timeStr = DateFormatters.timeShort.string(from: expensive.timeStart)
            let priceStr = PriceFormatter.formatSEK(expensive.total)
            tips.append(SmartTip(
                icon: "exclamationmark.triangle.fill",
                text: "Dyrast idag: \(timeStr) (\(priceStr) SEK/kWh) — undvik tunga förbrukare",
                savings: nil
            ))
        }

        return tips
    }
}
