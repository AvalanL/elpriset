import Foundation
import ElprisetShared

@MainActor @Observable
final class TariffService {
    private(set) var dsoName: String = ""
    private(set) var gridFeePerKwh: Decimal = ElectricityConstants.defaultGridFeePerKwh
    private(set) var isLoading = false

    func lookupTariff(latitude: Double, longitude: Double) async {
        isLoading = true
        do {
            let result = try await TariffAPI.lookupByLocation(latitude: latitude, longitude: longitude)
            if let name = result.providerName {
                dsoName = name
            }
            if let tariffId = result.tariffs?.first?.id {
                let price = try await TariffAPI.energyPrice(tariffId: tariffId)
                gridFeePerKwh = price
            }
        } catch {
            // Use default grid fee
            gridFeePerKwh = ElectricityConstants.defaultGridFeePerKwh
        }
        isLoading = false
    }

    func setManual(dso: String, fee: Decimal) {
        dsoName = dso
        gridFeePerKwh = fee
    }
}
