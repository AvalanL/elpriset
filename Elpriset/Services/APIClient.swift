import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case httpError(Int)
    case noData
    case rateLimited

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Ogiltig URL"
        case .networkError(let error): return "Nätverksfel: \(error.localizedDescription)"
        case .decodingError: return "Kunde inte tolka data"
        case .httpError(let code): return "Serverfel (\(code))"
        case .noData: return "Ingen data tillgänglig"
        case .rateLimited: return "För många förfrågningar"
        }
    }
}

actor APIClient {
    static let shared = APIClient()

    private let session: URLSession
    private let decoder: JSONDecoder

    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.waitsForConnectivity = true
        self.session = URLSession(configuration: config)

        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }

    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.noData
        }

        guard 200..<300 ~= http.statusCode else {
            if http.statusCode == 429 {
                throw APIError.rateLimited
            }
            throw APIError.httpError(http.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
