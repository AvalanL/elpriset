import Foundation

enum PriceFormatter {
    private static let sekFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.locale = Locale(identifier: "sv_SE")
        f.numberStyle = .decimal
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        return f
    }()

    private static let oreFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.locale = Locale(identifier: "sv_SE")
        f.numberStyle = .decimal
        f.minimumFractionDigits = 1
        f.maximumFractionDigits = 1
        return f
    }()

    static func formatSEK(_ value: Decimal) -> String {
        sekFormatter.string(from: value as NSDecimalNumber) ?? "0,00"
    }

    static func formatOre(_ value: Decimal) -> String {
        let ore = value * 100
        return oreFormatter.string(from: ore as NSDecimalNumber) ?? "0,0"
    }

    static func formatted(_ value: Decimal, asOre: Bool) -> String {
        if asOre {
            return "\(formatOre(value)) öre/kWh"
        } else {
            return "\(formatSEK(value)) SEK/kWh"
        }
    }

    static func shortFormatted(_ value: Decimal, asOre: Bool) -> String {
        if asOre {
            return "\(formatOre(value)) öre"
        } else {
            return "\(formatSEK(value)) SEK"
        }
    }

    static func timeRange(start: Date, end: Date) -> String {
        "\(DateFormatters.timeShort.string(from: start))–\(DateFormatters.timeShort.string(from: end))"
    }
}
