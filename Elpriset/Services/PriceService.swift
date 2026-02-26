import Foundation
import ElprisetShared

@MainActor @Observable
final class PriceService {
    private(set) var todayPrices: [SpotPrice] = []
    private(set) var tomorrowPrices: [SpotPrice] = []
    private(set) var isLoading = false
    private(set) var error: APIError?
    private(set) var lastFetched: Date?

    func fetchPrices(for zone: PriceZone) async {
        isLoading = true
        error = nil

        // Fetch today
        do {
            todayPrices = try await fetchWithFallback(date: .now, zone: zone)
            lastFetched = .now
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }

        // Fetch tomorrow (available after ~13:00 CET)
        do {
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
            tomorrowPrices = try await fetchWithFallback(date: tomorrow, zone: zone)
        } catch {
            // Tomorrow's prices may not be available yet — that's ok
            tomorrowPrices = []
        }

        isLoading = false
    }

    private func fetchWithFallback(date: Date, zone: PriceZone) async throws -> [SpotPrice] {
        // 1. Primary: elprisetjustnu.se
        do {
            let prices = try await SpotPriceAPI.fetchPrices(for: date, zone: zone)
            if !prices.isEmpty { return prices }
        } catch { }

        // 2. Fallback: Sourceful
        do {
            let prices = try await FallbackPriceAPI.fetchFromSourceful(zone: zone, date: date)
            if !prices.isEmpty { return prices }
        } catch { }

        // 3. Fallback: Energi Data Service
        return try await FallbackPriceAPI.fetchFromEnergiData(zone: zone, date: date)
    }
}
