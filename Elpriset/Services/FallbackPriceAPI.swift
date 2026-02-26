import Foundation
import ElprisetShared

// MARK: - Sourceful spot price fallback

struct SourcefulPriceResponse: Codable {
    let data: [SourcefulPrice]?

    struct SourcefulPrice: Codable {
        let price: Double?
        let timestamp: String?
    }
}

// MARK: - Energi Data Service fallback

struct EnergiDataResponse: Codable {
    let records: [EnergiDataRecord]

    struct EnergiDataRecord: Codable {
        let HourUTC: String
        let SpotPriceEUR: Double?
        let PriceArea: String
    }
}

enum FallbackPriceAPI {
    // Sourceful: EUR/MWh hourly
    static func fetchFromSourceful(zone: PriceZone, date: Date? = nil) async throws -> [SpotPrice] {
        var urlString = "https://mainnet.srcful.dev/price/electricity/\(zone.rawValue)"
        if let date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            urlString += "?date=\(formatter.string(from: date))"
        }
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        let response = try await APIClient.shared.fetch(SourcefulPriceResponse.self, from: url)
        guard let data = response.data else { throw APIError.noData }

        let exchangeRate: Decimal = 11.5
        return data.compactMap { item -> SpotPrice? in
            guard let price = item.price, let timestamp = item.timestamp else { return nil }
            let eurPerMwh = Decimal(price)
            let eurPerKwh = eurPerMwh / 1000
            let sekPerKwh = eurPerKwh * exchangeRate

            guard let date = SharedFormatters.iso8601NoFraction.date(from: timestamp) else { return nil }
            let end = Calendar.current.date(byAdding: .hour, value: 1, to: date)!

            return SpotPrice(
                sekPerKwh: sekPerKwh,
                eurPerKwh: eurPerKwh,
                exchangeRate: exchangeRate,
                timeStart: date,
                timeEnd: end
            )
        }
    }

    // Energi Data Service: EUR per MWh
    static func fetchFromEnergiData(zone: PriceZone, date: Date) async throws -> [SpotPrice] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: date)

        let encoded = "{\"PriceArea\":\"\(zone.rawValue)\"}".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://api.energidataservice.dk/dataset/Elspotprices?limit=96&filter=\(encoded)&start=\(dateStr)&sort=HourUTC%20asc") else {
            throw APIError.invalidURL
        }

        let response = try await APIClient.shared.fetch(EnergiDataResponse.self, from: url)
        let exchangeRate: Decimal = 11.5
        let isoFormatter = ISO8601DateFormatter()

        return response.records.compactMap { record -> SpotPrice? in
            guard let eurPrice = record.SpotPriceEUR else { return nil }
            let eurPerMwh = Decimal(eurPrice)
            let eurPerKwh = eurPerMwh / 1000
            let sekPerKwh = eurPerKwh * exchangeRate

            guard let date = isoFormatter.date(from: record.HourUTC) else { return nil }
            let end = Calendar.current.date(byAdding: .hour, value: 1, to: date)!

            return SpotPrice(
                sekPerKwh: sekPerKwh,
                eurPerKwh: eurPerKwh,
                exchangeRate: exchangeRate,
                timeStart: date,
                timeEnd: end
            )
        }
    }
}
