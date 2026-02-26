import SwiftUI
import ElprisetShared

struct PriceColors {
    // MARK: - Default palette
    static let veryCheap = Color(hex: "#8FD5A6")
    static let cheap = Color(hex: "#B8E6C8")
    static let normal = Color(hex: "#D4EFDD")
    static let expensive = Color(hex: "#F5C882")
    static let veryExpensive = Color(hex: "#E88F8F")

    // MARK: - Accessible palette (color-blind safe)
    static let veryCheapAccessible = Color(hex: "#004488")
    static let cheapAccessible = Color(hex: "#6699CC")
    static let normalAccessible = Color(hex: "#BBBBBB")
    static let expensiveAccessible = Color(hex: "#EE7733")
    static let veryExpensiveAccessible = Color(hex: "#CC3311")

    static func color(for level: PriceLevel, accessible: Bool = false) -> Color {
        if accessible {
            switch level {
            case .veryCheap: return veryCheapAccessible
            case .cheap: return cheapAccessible
            case .normal: return normalAccessible
            case .expensive: return expensiveAccessible
            case .veryExpensive: return veryExpensiveAccessible
            }
        } else {
            switch level {
            case .veryCheap: return veryCheap
            case .cheap: return cheap
            case .normal: return normal
            case .expensive: return expensive
            case .veryExpensive: return veryExpensive
            }
        }
    }
}
