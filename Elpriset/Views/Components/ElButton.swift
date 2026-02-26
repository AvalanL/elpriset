import SwiftUI

enum ElButtonStyle {
    case primary
    case secondary
    case tertiary
}

struct ElButton: View {
    let title: String
    let style: ElButtonStyle
    let icon: String?
    let action: () -> Void

    init(_ title: String, style: ElButtonStyle = .primary, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: ElSpacing.sm) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                }
                Text(title)
                    .font(.elLabelLarge)
            }
            .frame(maxWidth: .infinity)
            .frame(height: style == .tertiary ? 44 : 52)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(Capsule())
            .overlay {
                if style == .tertiary {
                    Capsule()
                        .stroke(Color.elBackgroundTertiary, lineWidth: 1)
                }
            }
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: return .elTextOnDark
        case .secondary: return .elTextOnGreen
        case .tertiary: return .elTextSecondary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: return .elSurfaceDark
        case .secondary: return .elGreen
        case .tertiary: return .clear
        }
    }
}
