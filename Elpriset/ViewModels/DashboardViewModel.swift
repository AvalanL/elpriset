import Foundation
import SwiftUI
import WidgetKit
import ElprisetShared

@MainActor @Observable
final class DashboardViewModel {
    // MARK: - State
    private(set) var todayTotalPrices: [TotalPrice] = []
    private(set) var tomorrowTotalPrices: [TotalPrice] = []
    private(set) var currentPrice: TotalPrice?
    private(set) var cheapestRemaining: TotalPrice?
    private(set) var mostExpensiveRemaining: TotalPrice?
    private(set) var tips: [CostCalculator.SmartTip] = []
    private(set) var isLoading = false
    private(set) var error: String?
    private(set) var lastUpdated: Date?

    var yesterdayAveragePrice: Decimal?
    var showTotalCost = true
    var selectedChartType = 0 // 0 = bar, 1 = line

    // MARK: - Dependencies
    private let priceService = PriceService()

    // MARK: - Computed
    var trendPercentage: Decimal? {
        guard let current = currentPrice?.total, let yesterday = yesterdayAveragePrice, yesterday > 0 else {
            return nil
        }
        return ((current - yesterday) / yesterday) * 100
    }

    var hasTomorrowPrices: Bool {
        !tomorrowTotalPrices.isEmpty
    }

    // MARK: - Actions
    @MainActor
    func loadPrices(zone: PriceZone, gridFee: Decimal, includeVAT: Bool, includeGridFee: Bool) async {
        isLoading = true
        error = nil

        await priceService.fetchPrices(for: zone)

        if let apiError = priceService.error {
            // Try with mock data as fallback for demo
            if priceService.todayPrices.isEmpty {
                let mockSpots = MockData.todayPrices()
                todayTotalPrices = CostCalculator.totalPrices(
                    from: mockSpots, gridFee: gridFee,
                    includeVAT: includeVAT, includeGridFee: includeGridFee
                )
                error = apiError.localizedDescription
            }
        }

        if !priceService.todayPrices.isEmpty {
            todayTotalPrices = CostCalculator.totalPrices(
                from: priceService.todayPrices, gridFee: gridFee,
                includeVAT: includeVAT, includeGridFee: includeGridFee
            )
        }

        if !priceService.tomorrowPrices.isEmpty {
            tomorrowTotalPrices = CostCalculator.totalPrices(
                from: priceService.tomorrowPrices, gridFee: gridFee,
                includeVAT: includeVAT, includeGridFee: includeGridFee
            )
        }

        updateDerivedState()
        syncToWidgetStore(zone: zone)
        lastUpdated = .now
        isLoading = false
    }

    @MainActor
    func loadMockData(gridFee: Decimal = 0.35) {
        let spots = MockData.todayPrices()
        todayTotalPrices = CostCalculator.totalPrices(from: spots, gridFee: gridFee)

        let tomorrowSpots = MockData.tomorrowPrices()
        tomorrowTotalPrices = CostCalculator.totalPrices(from: tomorrowSpots, gridFee: gridFee)

        updateDerivedState()
        lastUpdated = .now
    }

    private func updateDerivedState() {
        currentPrice = CostCalculator.currentPrice(from: todayTotalPrices)
        cheapestRemaining = CostCalculator.cheapestRemaining(from: todayTotalPrices)
        mostExpensiveRemaining = CostCalculator.mostExpensiveRemaining(from: todayTotalPrices)
        tips = CostCalculator.generateTips(
            currentPrice: currentPrice,
            cheapest: cheapestRemaining,
            expensive: mostExpensiveRemaining
        )
    }

    private func syncToWidgetStore(zone: PriceZone) {
        guard let current = currentPrice else { return }

        // Encode today's prices for widget charts
        struct WidgetPrice: Codable {
            let price: Double
            let timeStart: Date
            let level: String
        }
        let widgetPrices = todayTotalPrices.map { p in
            WidgetPrice(
                price: NSDecimalNumber(decimal: p.total).doubleValue,
                timeStart: p.timeStart,
                level: p.priceLevel.rawValue
            )
        }
        let todayData = try? JSONEncoder().encode(widgetPrices)

        let tomorrowWidgetPrices = tomorrowTotalPrices.map { p in
            WidgetPrice(
                price: NSDecimalNumber(decimal: p.total).doubleValue,
                timeStart: p.timeStart,
                level: p.priceLevel.rawValue
            )
        }
        let tomorrowData = try? JSONEncoder().encode(tomorrowWidgetPrices)

        WidgetDataStore.shared.update(
            currentPrice: current.total,
            priceLevel: current.priceLevel.rawValue,
            todayPrices: todayData,
            tomorrowPrices: tomorrowData,
            cheapestTime: cheapestRemaining.map { DateFormatters.timeShort.string(from: $0.timeStart) },
            cheapestPrice: cheapestRemaining?.total,
            expensiveTime: mostExpensiveRemaining.map { DateFormatters.timeShort.string(from: $0.timeStart) },
            expensivePrice: mostExpensiveRemaining?.total,
            zone: zone.rawValue,
            showTotal: showTotalCost
        )

        WidgetCenter.shared.reloadAllTimelines()
    }
}
