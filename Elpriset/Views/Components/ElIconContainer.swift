import SwiftUI

enum ElIconContainerSize {
    case compact // 24pt
    case standard // 32pt
    case hero // 40pt

    var diameter: CGFloat {
        switch self {
        case .compact: return 24
        case .standard: return 32
        case .hero: return 40
        }
    }

    var iconScale: CGFloat { 0.6 }
}

enum ElIconContainerStyle {
    case dark
    case greenOnDark
}

struct ElIconContainer: View {
    let icon: String
    let size: ElIconContainerSize
    let style: ElIconContainerStyle

    init(_ icon: String, size: ElIconContainerSize = .standard, style: ElIconContainerStyle = .dark) {
        self.icon = icon
        self.size = size
        self.style = style
    }

    var body: some View {
        Image(systemName: icon)
            .font(.system(size: size.diameter * size.iconScale))
            .foregroundStyle(iconColor)
            .frame(width: size.diameter, height: size.diameter)
            .background(backgroundColor)
            .clipShape(Circle())
    }

    private var iconColor: Color {
        switch style {
        case .dark: return .elTextOnDark
        case .greenOnDark: return .elGreenDark
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .dark: return .elSurfaceDark
        case .greenOnDark: return .elGreenDark.opacity(0.15)
        }
    }
}
