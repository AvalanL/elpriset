import Foundation

public final class WidgetDataStore: @unchecked Sendable {
    private let defaults: UserDefaults

    public static let shared = WidgetDataStore()

    private init() {
        self.defaults = UserDefaults(suiteName: ElectricityConstants.appGroupIdentifier) ?? .standard
    }

    // MARK: - Keys
    private enum Keys {
        static let currentPrice = "widget_currentPrice"
        static let currentPriceLevel = "widget_currentPriceLevel"
        static let todayPrices = "widget_todayPrices"
        static let tomorrowPrices = "widget_tomorrowPrices"
        static let cheapestRemainingTime = "widget_cheapestRemainingTime"
        static let cheapestRemainingPrice = "widget_cheapestRemainingPrice"
        static let mostExpensiveRemainingTime = "widget_mostExpensiveRemainingTime"
        static let mostExpensiveRemainingPrice = "widget_mostExpensiveRemainingPrice"
        static let priceZone = "widget_priceZone"
        static let lastUpdated = "widget_lastUpdated"
        static let showTotalCost = "widget_showTotalCost"
    }

    // MARK: - Write
    public func update(
        currentPrice: Decimal,
        priceLevel: String,
        todayPrices: Data?,
        tomorrowPrices: Data?,
        cheapestTime: String?,
        cheapestPrice: Decimal?,
        expensiveTime: String?,
        expensivePrice: Decimal?,
        zone: String,
        showTotal: Bool
    ) {
        defaults.set(NSDecimalNumber(decimal: currentPrice).doubleValue, forKey: Keys.currentPrice)
        defaults.set(priceLevel, forKey: Keys.currentPriceLevel)
        defaults.set(todayPrices, forKey: Keys.todayPrices)
        defaults.set(tomorrowPrices, forKey: Keys.tomorrowPrices)
        defaults.set(cheapestTime, forKey: Keys.cheapestRemainingTime)
        if let cheapestPrice {
            defaults.set(NSDecimalNumber(decimal: cheapestPrice).doubleValue, forKey: Keys.cheapestRemainingPrice)
        }
        defaults.set(expensiveTime, forKey: Keys.mostExpensiveRemainingTime)
        if let expensivePrice {
            defaults.set(NSDecimalNumber(decimal: expensivePrice).doubleValue, forKey: Keys.mostExpensiveRemainingPrice)
        }
        defaults.set(zone, forKey: Keys.priceZone)
        defaults.set(Date.now.timeIntervalSince1970, forKey: Keys.lastUpdated)
        defaults.set(showTotal, forKey: Keys.showTotalCost)
    }

    // MARK: - Read
    public var currentPrice: Decimal {
        Decimal(defaults.double(forKey: Keys.currentPrice))
    }

    public var currentPriceLevel: String {
        defaults.string(forKey: Keys.currentPriceLevel) ?? PriceLevel.normal.rawValue
    }

    public var todayPricesData: Data? {
        defaults.data(forKey: Keys.todayPrices)
    }

    public var tomorrowPricesData: Data? {
        defaults.data(forKey: Keys.tomorrowPrices)
    }

    public var cheapestRemainingTime: String? {
        defaults.string(forKey: Keys.cheapestRemainingTime)
    }

    public var cheapestRemainingPrice: Decimal {
        Decimal(defaults.double(forKey: Keys.cheapestRemainingPrice))
    }

    public var mostExpensiveRemainingTime: String? {
        defaults.string(forKey: Keys.mostExpensiveRemainingTime)
    }

    public var mostExpensiveRemainingPrice: Decimal {
        Decimal(defaults.double(forKey: Keys.mostExpensiveRemainingPrice))
    }

    public var priceZone: String {
        defaults.string(forKey: Keys.priceZone) ?? PriceZone.SE3.rawValue
    }

    public var lastUpdated: Date? {
        let ts = defaults.double(forKey: Keys.lastUpdated)
        return ts > 0 ? Date(timeIntervalSince1970: ts) : nil
    }

    public var showTotalCost: Bool {
        defaults.bool(forKey: Keys.showTotalCost)
    }
}
