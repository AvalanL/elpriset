import SwiftUI

// Minimal color definitions for widget target
extension Color {
    static let wGreen = Color(red: 143/255, green: 213/255, blue: 166/255)
    static let wGreenLight = Color(red: 212/255, green: 239/255, blue: 221/255)
    static let wSurfaceDark = Color(red: 26/255, green: 26/255, blue: 26/255)
    static let wTextSecondary = Color(red: 110/255, green: 110/255, blue: 115/255)
    static let wTextTertiary = Color(red: 174/255, green: 174/255, blue: 178/255)

    static func widgetPriceColor(for level: String) -> Color {
        switch level {
        case "veryCheap": return Color(red: 143/255, green: 213/255, blue: 166/255)
        case "cheap": return Color(red: 184/255, green: 230/255, blue: 200/255)
        case "normal": return Color(red: 212/255, green: 239/255, blue: 221/255)
        case "expensive": return Color(red: 245/255, green: 200/255, blue: 130/255)
        case "veryExpensive": return Color(red: 232/255, green: 143/255, blue: 143/255)
        default: return Color(red: 212/255, green: 239/255, blue: 221/255)
        }
    }
}
