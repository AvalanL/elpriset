import UIKit
import ElprisetShared

@MainActor
enum HapticManager {
    private static let selectionGenerator = UISelectionFeedbackGenerator()
    private static let lightImpact = UIImpactFeedbackGenerator(style: .light)
    private static let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    private static let notificationGenerator = UINotificationFeedbackGenerator()

    static func selection() {
        guard !UIAccessibility.isReduceMotionEnabled else { return }
        selectionGenerator.selectionChanged()
    }

    static func lightTap() {
        lightImpact.impactOccurred()
    }

    static func mediumTap() {
        mediumImpact.impactOccurred()
    }

    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(type)
    }

    static func priceChange(level: PriceLevel) {
        switch level {
        case .veryCheap, .cheap:
            notification(.success)
        case .normal:
            break
        case .expensive, .veryExpensive:
            notification(.warning)
        }
    }
}
