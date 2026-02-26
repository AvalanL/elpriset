import SwiftUI

extension Color {
    // MARK: - Foundation
    static let elBackground = Color(light: Color(hex: "#FFFFFF"), dark: Color(hex: "#000000"))
    static let elBackgroundSecondary = Color(light: Color(hex: "#F5F5F7"), dark: Color(hex: "#1C1C1E"))
    static let elBackgroundTertiary = Color(light: Color(hex: "#EEEEEF"), dark: Color(hex: "#2C2C2E"))
    static let elSurfaceDark = Color(light: Color(hex: "#1A1A1A"), dark: Color(hex: "#2C2C2E"))
    static let elSurfaceDarkElevated = Color(light: Color(hex: "#2C2C2E"), dark: Color(hex: "#3A3A3C"))

    // MARK: - Accents
    static let elGreen = Color(hex: "#8FD5A6")
    static let elGreenLight = Color(light: Color(hex: "#D4EFDD"), dark: Color(hex: "#1A3D26"))
    static let elGreenDark = Color(hex: "#3A7D52")
    static let elLavender = Color(light: Color(hex: "#EDE5F5"), dark: Color(hex: "#2D2640"))
    static let elLavenderMid = Color(hex: "#D8CCE8")

    // MARK: - Text
    static let elTextPrimary = Color(light: Color(hex: "#000000"), dark: Color(hex: "#FFFFFF"))
    static let elTextSecondary = Color(light: Color(hex: "#6E6E73"), dark: Color(hex: "#98989D"))
    static let elTextTertiary = Color(light: Color(hex: "#AEAEB2"), dark: Color(hex: "#636366"))
    static let elTextOnDark = Color(hex: "#FFFFFF")
    static let elTextOnDarkSecondary = Color(hex: "#A1A1A6")
    static let elTextOnGreen = Color(hex: "#1A1A1A")

    // MARK: - Semantic
    static let elPositive = Color(hex: "#3A7D52")
    static let elNegative = Color(hex: "#D94545")
    static let elWarning = Color(hex: "#E8A640")
    static let elInfo = Color(hex: "#7B8FCC")
}

extension Color {
    init(light: Color, dark: Color) {
        self.init(uiColor: UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}
