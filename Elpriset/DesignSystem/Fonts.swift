import SwiftUI

extension Font {
    // MARK: - Display (SF Pro Rounded)
    static let elDisplayHero = Font.system(size: 48, weight: .bold, design: .rounded)
    static let elDisplayLarge = Font.system(size: 34, weight: .bold, design: .rounded)
    static let elDisplayMedium = Font.system(size: 28, weight: .semibold, design: .rounded)
    static let elDisplaySmall = Font.system(size: 22, weight: .semibold, design: .rounded)

    // MARK: - Headings (SF Pro)
    static let elHeadingLarge = Font.system(size: 24, weight: .bold)
    static let elHeadingMedium = Font.system(size: 20, weight: .semibold)
    static let elHeadingSmall = Font.system(size: 17, weight: .semibold)

    // MARK: - Body (SF Pro)
    static let elBodyLarge = Font.system(size: 17, weight: .regular)
    static let elBodyMedium = Font.system(size: 15, weight: .regular)
    static let elBodySmall = Font.system(size: 13, weight: .regular)

    // MARK: - Labels (SF Pro)
    static let elLabelLarge = Font.system(size: 15, weight: .medium)
    static let elLabelMedium = Font.system(size: 13, weight: .medium)
    static let elLabelSmall = Font.system(size: 11, weight: .medium)

    // MARK: - Unit (SF Pro Rounded)
    static let elUnit = Font.system(size: 17, weight: .regular, design: .rounded)
}
