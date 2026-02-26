import SwiftUI

enum ElCardStyle {
    case lavender
    case dark
    case green
    case bordered
}

struct ElCard<Content: View>: View {
    let style: ElCardStyle
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(style == .lavender ? ElSpacing.lg : ElSpacing.base)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: style == .lavender ? ElRadius.xl : ElRadius.lg))
            .overlay {
                if style == .bordered {
                    RoundedRectangle(cornerRadius: ElRadius.lg)
                        .stroke(Color.elBackgroundTertiary, lineWidth: 1)
                }
            }
    }

    private var backgroundColor: Color {
        switch style {
        case .lavender: return .elLavender
        case .dark: return .elSurfaceDark
        case .green: return .elGreen
        case .bordered: return .elBackground
        }
    }
}
