import Foundation
import SwiftData
import ElprisetShared

@Observable
final class SettingsViewModel {
    var priceZone: PriceZone = .SE3
    var dsoName: String = ""
    var gridFeePerKwh: Decimal = ElectricityConstants.defaultGridFeePerKwh
    var showOrePerKwh = false
    var includeVAT = true
    var includeGridFee = true
    var useAccessibleColors = false
    var monthlyConsumptionKwh: Decimal = ElectricityConstants.defaultMonthlyConsumptionKwh
    var showGnistan = true
    var showGnistanInNotifications = true

    @MainActor
    func load(from context: ModelContext) {
        let descriptor = FetchDescriptor<UserSettings>()
        guard let settings = try? context.fetch(descriptor).first else { return }

        priceZone = settings.zone
        dsoName = settings.dsoName
        gridFeePerKwh = settings.gridFeePerKwh
        showOrePerKwh = settings.showOrePerKwh
        includeVAT = settings.includeVAT
        includeGridFee = settings.includeGridFee
        useAccessibleColors = settings.useAccessibleColors
        monthlyConsumptionKwh = settings.monthlyConsumptionKwh
        showGnistan = settings.showGnistan
        showGnistanInNotifications = settings.showGnistanInNotifications
    }

    @MainActor
    func save(to context: ModelContext) {
        let descriptor = FetchDescriptor<UserSettings>()
        let settings = (try? context.fetch(descriptor).first) ?? UserSettings()

        settings.priceZone = priceZone.rawValue
        settings.dsoName = dsoName
        settings.gridFeePerKwh = gridFeePerKwh
        settings.showOrePerKwh = showOrePerKwh
        settings.includeVAT = includeVAT
        settings.includeGridFee = includeGridFee
        settings.useAccessibleColors = useAccessibleColors
        settings.monthlyConsumptionKwh = monthlyConsumptionKwh
        settings.showGnistan = showGnistan
        settings.showGnistanInNotifications = showGnistanInNotifications

        if context.hasChanges {
            context.insert(settings)
            try? context.save()
        }
    }
}
