import UserNotifications
import ElprisetShared

final class NotificationService: Sendable {
    static let shared = NotificationService()

    private init() {}

    func requestPermission() async -> Bool {
        do {
            return try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            return false
        }
    }

    func scheduleTomorrowPricesNotification(cheapestTime: String, cheapestPrice: Decimal, expensiveTime: String, expensivePrice: Decimal) {
        let content = UNMutableNotificationContent()
        content.title = "Gnistan hittade imorgons priser!"
        content.body = "Billigaste kvarten: \(cheapestTime) (\(PriceFormatter.formatSEK(cheapestPrice)) SEK/kWh). Dyrast: \(expensiveTime) (\(PriceFormatter.formatSEK(expensivePrice)) SEK)"
        content.sound = .default
        content.categoryIdentifier = "tomorrowPrices"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "tomorrow-prices-\(Date.now.timeIntervalSince1970)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func schedulePriceAlert(isLow: Bool, price: Decimal, time: String) {
        let content = UNMutableNotificationContent()
        if isLow {
            content.title = "Billig el just nu!"
            content.body = "Bara \(PriceFormatter.formatSEK(price)) SEK/kWh — nu är det smart att köra tvättmaskinen."
        } else {
            content.title = "Elpriset stiger snart"
            content.body = "\(time) kostar elen \(PriceFormatter.formatSEK(price)) SEK/kWh. Undvik tunga förbrukare."
        }
        content.sound = .default
        content.categoryIdentifier = "priceAlert"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "price-alert-\(Date.now.timeIntervalSince1970)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
