import Foundation
import SwiftData
import ElprisetShared

actor CacheService {
    private let container: ModelContainer

    init(container: ModelContainer) {
        self.container = container
    }

    @MainActor
    func cachePrices(_ prices: [SpotPrice], zone: PriceZone) throws {
        let context = container.mainContext
        for price in prices {
            let cached = CachedSpotPrice(from: price, zone: zone)
            context.insert(cached)
        }
        try context.save()
    }

    @MainActor
    func getCachedPrices(for date: Date, zone: PriceZone) throws -> [SpotPrice] {
        let context = container.mainContext
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let zoneStr = zone.rawValue

        let descriptor = FetchDescriptor<CachedSpotPrice>(
            predicate: #Predicate<CachedSpotPrice> {
                $0.zone == zoneStr &&
                $0.timeStart >= startOfDay &&
                $0.timeStart < endOfDay
            },
            sortBy: [SortDescriptor(\.timeStart)]
        )

        let cached = try context.fetch(descriptor)
        return cached.map { $0.toSpotPrice() }
    }

    @MainActor
    func clearOldCache(olderThan days: Int = 7) throws {
        let context = container.mainContext
        let cutoff = Calendar.current.date(byAdding: .day, value: -days, to: .now)!

        let descriptor = FetchDescriptor<CachedSpotPrice>(
            predicate: #Predicate<CachedSpotPrice> { $0.fetchedAt < cutoff }
        )
        let old = try context.fetch(descriptor)
        for item in old {
            context.delete(item)
        }
        try context.save()
    }
}
