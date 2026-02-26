import Foundation

public enum ElectricityConstants {
    public static let electricityTaxPerKwh: Decimal = 0.428
    public static let vatRate: Decimal = 0.25
    public static let vatMultiplier: Decimal = 1.25

    public static let veryCheapThreshold: Decimal = 0.80
    public static let cheapThreshold: Decimal = 1.20
    public static let normalThreshold: Decimal = 2.00
    public static let expensiveThreshold: Decimal = 3.00

    public static let appGroupIdentifier = "group.se.elpriset.shared"
    public static let backgroundTaskIdentifier = "se.elpriset.app.refresh"

    public static let defaultGridFeePerKwh: Decimal = 0.35
    public static let defaultMonthlyConsumptionKwh: Decimal = 250
}
