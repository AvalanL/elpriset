import Foundation

// MARK: - Spot Price (from API)

public struct SpotPrice: Codable, Identifiable, Sendable {
    public var id: String { timeStart.ISO8601Format() }
    public let sekPerKwh: Decimal
    public let eurPerKwh: Decimal
    public let exchangeRate: Decimal
    public let timeStart: Date
    public let timeEnd: Date

    public init(sekPerKwh: Decimal, eurPerKwh: Decimal, exchangeRate: Decimal, timeStart: Date, timeEnd: Date) {
        self.sekPerKwh = sekPerKwh
        self.eurPerKwh = eurPerKwh
        self.exchangeRate = exchangeRate
        self.timeStart = timeStart
        self.timeEnd = timeEnd
    }

    enum CodingKeys: String, CodingKey {
        case sekPerKwh = "SEK_per_kWh"
        case eurPerKwh = "EUR_per_kWh"
        case exchangeRate = "EXR"
        case timeStart = "time_start"
        case timeEnd = "time_end"
    }
}

// MARK: - Total Price

public struct TotalPrice: Sendable {
    public let spotPrice: Decimal
    public let gridFee: Decimal
    public let electricityTax: Decimal
    public let vatMultiplier: Decimal
    public let timeStart: Date
    public let timeEnd: Date

    public var total: Decimal {
        (spotPrice + gridFee + electricityTax) * vatMultiplier
    }

    public var totalWithoutVAT: Decimal {
        spotPrice + gridFee + electricityTax
    }

    public var priceLevel: PriceLevel {
        switch total {
        case ..<0.80: return .veryCheap
        case ..<1.20: return .cheap
        case ..<2.00: return .normal
        case ..<3.00: return .expensive
        default: return .veryExpensive
        }
    }

    public init(spotPrice: Decimal, gridFee: Decimal, electricityTax: Decimal = ElectricityConstants.electricityTaxPerKwh, vatMultiplier: Decimal = ElectricityConstants.vatMultiplier, timeStart: Date, timeEnd: Date) {
        self.spotPrice = spotPrice
        self.gridFee = gridFee
        self.electricityTax = electricityTax
        self.vatMultiplier = vatMultiplier
        self.timeStart = timeStart
        self.timeEnd = timeEnd
    }
}

// MARK: - Price Level

public enum PriceLevel: String, Codable, CaseIterable, Sendable {
    case veryCheap
    case cheap
    case normal
    case expensive
    case veryExpensive

    public var label: String {
        switch self {
        case .veryCheap: return "Mycket billigt"
        case .cheap: return "Billigt"
        case .normal: return "Normalt"
        case .expensive: return "Dyrt"
        case .veryExpensive: return "Mycket dyrt"
        }
    }

    public var icon: String {
        switch self {
        case .veryCheap, .cheap: return "checkmark.circle.fill"
        case .normal: return "minus.circle.fill"
        case .expensive, .veryExpensive: return "exclamationmark.triangle.fill"
        }
    }
}

// MARK: - Price Zone

public enum PriceZone: String, Codable, CaseIterable, Identifiable, Sendable {
    case SE1, SE2, SE3, SE4

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .SE1: return "SE1 – Luleå"
        case .SE2: return "SE2 – Sundsvall"
        case .SE3: return "SE3 – Stockholm"
        case .SE4: return "SE4 – Malmö"
        }
    }

    public var fullDescription: String {
        switch self {
        case .SE1: return "SE1 – Luleå (Norra Sverige)"
        case .SE2: return "SE2 – Sundsvall (Mellersta Sverige)"
        case .SE3: return "SE3 – Stockholm (Södra Mellansverige)"
        case .SE4: return "SE4 – Malmö (Södra Sverige)"
        }
    }

    public static func fromLatitude(_ latitude: Double) -> PriceZone {
        switch latitude {
        case 65.0...: return .SE1
        case 62.0..<65.0: return .SE2
        case 56.0..<62.0: return .SE3
        default: return .SE4
        }
    }
}
