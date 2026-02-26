import Foundation
import ElprisetShared

enum MockData {
    static let defaultZone = PriceZone.SE3
    static let defaultGridFee: Decimal = 0.35

    // MARK: - 96 realistic 15-minute spot prices for today (SE3 winter pattern)
    static func todayPrices(date: Date = .now) -> [SpotPrice] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)

        // Realistic Swedish winter price curve (öre/kWh then converted to SEK)
        // Low at night, morning peak ~07-09, midday dip, evening peak ~17-20
        let hourlyPattern: [Decimal] = [
            0.12, 0.10, 0.08, 0.07, 0.06, 0.08, // 00-05: night low
            0.15, 0.42, 0.65, 0.55, 0.38, 0.30,  // 06-11: morning peak
            0.25, 0.22, 0.18, 0.20, 0.35, 0.85,  // 12-17: afternoon + evening ramp
            1.20, 0.95, 0.55, 0.35, 0.25, 0.18   // 18-23: evening peak + descent
        ]

        var prices: [SpotPrice] = []
        for hour in 0..<24 {
            let basePrice = hourlyPattern[hour]
            for quarter in 0..<4 {
                let variation = Decimal(Double.random(in: -0.02...0.02))
                let price = max(0, basePrice + variation)
                let minuteOffset = hour * 60 + quarter * 15
                let start = calendar.date(byAdding: .minute, value: minuteOffset, to: startOfDay)!
                let end = calendar.date(byAdding: .minute, value: 15, to: start)!

                prices.append(SpotPrice(
                    sekPerKwh: price,
                    eurPerKwh: price / 11.5,
                    exchangeRate: 11.5,
                    timeStart: start,
                    timeEnd: end
                ))
            }
        }
        return prices
    }

    // MARK: - Tomorrow prices (available after 13:00)
    static func tomorrowPrices(date: Date = .now) -> [SpotPrice] {
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: date)!
        return todayPrices(date: tomorrow)
    }

    // MARK: - Total prices from spot prices
    static func totalPrices(from spots: [SpotPrice], gridFee: Decimal = defaultGridFee) -> [TotalPrice] {
        spots.map { spot in
            TotalPrice(
                spotPrice: spot.sekPerKwh,
                gridFee: gridFee,
                timeStart: spot.timeStart,
                timeEnd: spot.timeEnd
            )
        }
    }

    // MARK: - Sample current price
    static var currentSpotPrice: SpotPrice {
        let now = Date.now
        return todayPrices().first(where: { $0.timeStart <= now && $0.timeEnd > now })
            ?? todayPrices()[0]
    }

    static var currentTotalPrice: TotalPrice {
        let spot = currentSpotPrice
        return TotalPrice(
            spotPrice: spot.sekPerKwh,
            gridFee: defaultGridFee,
            timeStart: spot.timeStart,
            timeEnd: spot.timeEnd
        )
    }
}
