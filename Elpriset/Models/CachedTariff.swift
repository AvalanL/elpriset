import Foundation
import SwiftData
import ElprisetShared

@Model
final class CachedTariff {
    var dsoName: String
    var energyPricePerKwh: Decimal
    var fixedMonthlyFee: Decimal
    var zone: String
    var fetchedAt: Date

    init(dsoName: String, energyPricePerKwh: Decimal, fixedMonthlyFee: Decimal, zone: PriceZone) {
        self.dsoName = dsoName
        self.energyPricePerKwh = energyPricePerKwh
        self.fixedMonthlyFee = fixedMonthlyFee
        self.zone = zone.rawValue
        self.fetchedAt = Date.now
    }
}
