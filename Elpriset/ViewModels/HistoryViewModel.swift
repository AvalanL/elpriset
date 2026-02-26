import Foundation
import ElprisetShared

@Observable
final class HistoryViewModel {
    var selectedPeriod = 0 // 0=day, 1=week, 2=month, 3=year
    private(set) var dailyAverages: [(date: Date, average: Decimal)] = []
    private(set) var isLoading = false

    struct MonthStat: Identifiable {
        let id = UUID()
        let month: String
        let average: Decimal
        let min: Decimal
        let max: Decimal
    }

    private(set) var monthlyStats: [MonthStat] = []

    @MainActor
    func loadMockHistory() {
        isLoading = true
        let calendar = Calendar.current

        // Generate 12 months of mock data
        monthlyStats = (0..<12).map { monthsAgo in
            let date = calendar.date(byAdding: .month, value: -monthsAgo, to: .now)!
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "sv_SE")
            formatter.dateFormat = "MMM"
            let basePrice = Decimal(Double.random(in: 0.8...2.5))
            return MonthStat(
                month: formatter.string(from: date).capitalized,
                average: basePrice,
                min: basePrice * Decimal(0.3),
                max: basePrice * Decimal(2.2)
            )
        }.reversed()

        // Daily averages for the last 30 days
        dailyAverages = (0..<30).map { daysAgo in
            let date = calendar.date(byAdding: .day, value: -daysAgo, to: .now)!
            let avg = Decimal(Double.random(in: 0.5...3.0))
            return (date: date, average: avg)
        }.reversed()

        isLoading = false
    }
}
