import Foundation

public enum SharedFormatters {
    public nonisolated(unsafe) static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    public nonisolated(unsafe) static let iso8601NoFraction: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    public nonisolated(unsafe) static let apiDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM'-'dd"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()
}
