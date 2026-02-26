import Foundation
import SwiftData
import ElprisetShared

@Model
final class CachedSpotPrice {
    var sekPerKwh: Decimal
    var eurPerKwh: Decimal
    var exchangeRate: Decimal
    var timeStart: Date
    var timeEnd: Date
    var zone: String
    var fetchedAt: Date

    init(from spot: SpotPrice, zone: PriceZone) {
        self.sekPerKwh = spot.sekPerKwh
        self.eurPerKwh = spot.eurPerKwh
        self.exchangeRate = spot.exchangeRate
        self.timeStart = spot.timeStart
        self.timeEnd = spot.timeEnd
        self.zone = zone.rawValue
        self.fetchedAt = Date.now
    }

    func toSpotPrice() -> SpotPrice {
        SpotPrice(
            sekPerKwh: sekPerKwh,
            eurPerKwh: eurPerKwh,
            exchangeRate: exchangeRate,
            timeStart: timeStart,
            timeEnd: timeEnd
        )
    }
}
