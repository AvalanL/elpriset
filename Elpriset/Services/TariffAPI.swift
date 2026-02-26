import Foundation
import ElprisetShared

struct TariffLookupResponse: Codable {
    let providerId: String?
    let providerName: String?
    let tariffs: [TariffInfo]?

    struct TariffInfo: Codable {
        let id: String?
        let name: String?
    }
}

struct TariffEnergyPriceResponse: Codable {
    let price: Double?
    let unit: String?
}

enum TariffAPI {
    private static let baseURL = "https://mainnet.srcful.dev/price/tariffs"

    static func lookupByLocation(latitude: Double, longitude: Double) async throws -> TariffLookupResponse {
        guard let url = URL(string: "\(baseURL)/lookup?lat=\(latitude)&lon=\(longitude)") else {
            throw APIError.invalidURL
        }
        return try await APIClient.shared.fetch(TariffLookupResponse.self, from: url)
    }

    static func energyPrice(tariffId: String, at date: Date = .now) async throws -> Decimal {
        let iso = date.ISO8601Format()
        guard let url = URL(string: "\(baseURL)/tariff/\(tariffId)/energyPrice/\(iso)") else {
            throw APIError.invalidURL
        }
        let response = try await APIClient.shared.fetch(TariffEnergyPriceResponse.self, from: url)
        guard let price = response.price else {
            throw APIError.noData
        }
        // Convert öre/kWh to SEK/kWh
        return Decimal(price) / 100
    }
}
