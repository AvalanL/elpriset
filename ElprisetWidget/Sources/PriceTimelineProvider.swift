import WidgetKit
import ElprisetShared

struct PriceTimelineProvider: TimelineProvider {
    private let store = WidgetDataStore.shared

    func placeholder(in context: Context) -> PriceEntry {
        .placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (PriceEntry) -> Void) {
        completion(currentEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PriceEntry>) -> Void) {
        let entry = currentEntry()
        // Refresh every 15 minutes
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: .now)!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func currentEntry() -> PriceEntry {
        // Decode today's prices from App Group
        var widgetPrices: [PriceEntry.WidgetPrice] = []
        if let data = store.todayPricesData {
            widgetPrices = (try? JSONDecoder().decode([PriceEntry.WidgetPrice].self, from: data)) ?? []
        }

        return PriceEntry(
            date: .now,
            currentPrice: store.currentPrice,
            priceLevel: store.currentPriceLevel,
            priceZone: store.priceZone,
            todayPrices: widgetPrices,
            cheapestTime: store.cheapestRemainingTime,
            cheapestPrice: store.cheapestRemainingPrice,
            mostExpensiveTime: store.mostExpensiveRemainingTime,
            mostExpensivePrice: store.mostExpensiveRemainingPrice,
            showTotalCost: store.showTotalCost
        )
    }
}
