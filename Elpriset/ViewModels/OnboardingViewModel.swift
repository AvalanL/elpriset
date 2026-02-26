import Foundation
import ElprisetShared

@MainActor @Observable
final class OnboardingViewModel {
    private(set) var detectedZone: PriceZone?
    private(set) var dsoName: String?
    private(set) var livePrice: TotalPrice?
    private(set) var isDetectingLocation = false
    var selectedZone: PriceZone = .SE3
    var currentPage = 0

    private let locationService = LocationService()
    private let tariffService = TariffService()
    private let priceService = PriceService()

    @MainActor
    func detectLocation() async {
        isDetectingLocation = true
        if let zone = await locationService.detectLocation() {
            detectedZone = zone
            selectedZone = zone

            if let lat = locationService.latitude, let lon = locationService.longitude {
                await tariffService.lookupTariff(latitude: lat, longitude: lon)
                dsoName = tariffService.dsoName.isEmpty ? nil : tariffService.dsoName
            }

            // Fetch live price for the aha moment
            await priceService.fetchPrices(for: zone)
            if let spot = priceService.todayPrices.first(where: { $0.timeStart <= .now && $0.timeEnd > .now }) {
                livePrice = TotalPrice(
                    spotPrice: spot.sekPerKwh,
                    gridFee: tariffService.gridFeePerKwh,
                    timeStart: spot.timeStart,
                    timeEnd: spot.timeEnd
                )
            }
        }
        isDetectingLocation = false
    }

    var gridFee: Decimal {
        tariffService.gridFeePerKwh
    }
}
