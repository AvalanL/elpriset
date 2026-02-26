import Foundation
import ElprisetShared

enum SpotPriceAPI {
    private static let baseURL = "https://www.elprisetjustnu.se/api/v1/prices"

    static func url(for date: Date, zone: PriceZone) -> URL? {
        let path = DateFormatters.apiPath.string(from: date)
        let urlString = "\(baseURL)/\(path)_\(zone.rawValue).json"
        return URL(string: urlString)
    }

    static func fetchPrices(for date: Date, zone: PriceZone) async throws -> [SpotPrice] {
        guard let url = url(for: date, zone: zone) else {
            throw APIError.invalidURL
        }
        return try await APIClient.shared.fetch([SpotPrice].self, from: url)
    }
}
