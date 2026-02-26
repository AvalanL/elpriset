import Foundation
import SwiftData
import ElprisetShared

@Model
final class UserSettings {
    var priceZone: String
    var dsoName: String
    var gridFeePerKwh: Decimal
    var showOrePerKwh: Bool
    var includeVAT: Bool
    var includeGridFee: Bool
    var useAccessibleColors: Bool
    var monthlyConsumptionKwh: Decimal
    var hasCompletedOnboarding: Bool
    var hasSeenTotalCostOnce: Bool
    var showGnistan: Bool
    var showGnistanInNotifications: Bool

    init() {
        self.priceZone = PriceZone.SE3.rawValue
        self.dsoName = ""
        self.gridFeePerKwh = ElectricityConstants.defaultGridFeePerKwh
        self.showOrePerKwh = false
        self.includeVAT = true
        self.includeGridFee = true
        self.useAccessibleColors = false
        self.monthlyConsumptionKwh = ElectricityConstants.defaultMonthlyConsumptionKwh
        self.hasCompletedOnboarding = false
        self.hasSeenTotalCostOnce = false
        self.showGnistan = true
        self.showGnistanInNotifications = true
    }

    var zone: PriceZone {
        PriceZone(rawValue: priceZone) ?? .SE3
    }
}
