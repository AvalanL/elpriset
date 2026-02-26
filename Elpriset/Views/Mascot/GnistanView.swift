import SwiftUI
import ElprisetShared

enum GnistanExpression: String {
    case neutral
    case happy
    case worried
    case sleeping
    case celebrating
}

struct GnistanView: View {
    let expression: GnistanExpression
    let size: CGFloat

    @State private var glowOpacity: Double = 0.3
    @State private var scale: CGFloat = 1.0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            // Glow
            Ellipse()
                .fill(glowColor.opacity(glowOpacity))
                .frame(width: size * 1.4, height: size * 1.2)
                .blur(radius: 8)

            // Body (teardrop shape)
            GnistanBody()
                .fill(
                    LinearGradient(
                        colors: [bodyColorTop, bodyColorBottom],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: size * 0.75, height: size)

            // Face
            GnistanFace(expression: expression)
                .frame(width: size * 0.5, height: size * 0.4)
                .offset(y: size * 0.05)

            // Sparkles (celebrating only)
            if expression == .celebrating {
                sparkles
            }
        }
        .scaleEffect(scale)
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                glowOpacity = expression == .sleeping ? 0.15 : 0.45
                scale = 1.02
            }
        }
        .animation(.easeInOut(duration: 0.6), value: expression)
        .accessibilityLabel(accessibilityLabel)
    }

    private var glowColor: Color {
        switch expression {
        case .neutral, .sleeping: return Color.elGreenLight
        case .happy, .celebrating: return Color.elGreen
        case .worried: return PriceColors.veryExpensive
        }
    }

    private var bodyColorBottom: Color {
        switch expression {
        case .neutral: return Color(hex: "#D4EFDD")
        case .happy, .celebrating: return Color(hex: "#8FD5A6")
        case .worried: return Color(hex: "#F5C882")
        case .sleeping: return Color(hex: "#D4EFDD")
        }
    }

    private var bodyColorTop: Color {
        switch expression {
        case .neutral: return Color(hex: "#E8F5EC")
        case .happy, .celebrating: return Color(hex: "#D4EFDD")
        case .worried: return Color(hex: "#E88F8F")
        case .sleeping: return Color(hex: "#E8F5EC")
        }
    }

    private var sparkles: some View {
        ForEach(0..<4, id: \.self) { i in
            Diamond()
                .fill(Color.white.opacity(0.6))
                .frame(width: 4, height: 4)
                .offset(
                    x: CGFloat([-15, 15, -10, 12][i]),
                    y: CGFloat([-20, -15, 10, 8][i])
                )
        }
    }

    private var accessibilityLabel: String {
        switch expression {
        case .neutral: return "Gnistan, neutral"
        case .happy: return "Gnistan, glad"
        case .worried: return "Gnistan, orolig"
        case .sleeping: return "Gnistan, sover"
        case .celebrating: return "Gnistan, firar"
        }
    }
}

// MARK: - Shapes

struct GnistanBody: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        // Teardrop: wide bottom, narrow top
        path.move(to: CGPoint(x: w * 0.5, y: 0))
        path.addCurve(
            to: CGPoint(x: w, y: h * 0.6),
            control1: CGPoint(x: w * 0.55, y: h * 0.1),
            control2: CGPoint(x: w, y: h * 0.35)
        )
        path.addCurve(
            to: CGPoint(x: w * 0.5, y: h),
            control1: CGPoint(x: w, y: h * 0.85),
            control2: CGPoint(x: w * 0.75, y: h)
        )
        path.addCurve(
            to: CGPoint(x: 0, y: h * 0.6),
            control1: CGPoint(x: w * 0.25, y: h),
            control2: CGPoint(x: 0, y: h * 0.85)
        )
        path.addCurve(
            to: CGPoint(x: w * 0.5, y: 0),
            control1: CGPoint(x: 0, y: h * 0.35),
            control2: CGPoint(x: w * 0.45, y: h * 0.1)
        )
        return path
    }
}

struct GnistanFace: View {
    let expression: GnistanExpression

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            ZStack {
                // Eyes
                switch expression {
                case .sleeping:
                    // Closed eyes (dashes)
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color(hex: "#1A1A1A"))
                        .frame(width: 8, height: 2)
                        .position(x: w * 0.35, y: h * 0.4)
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color(hex: "#1A1A1A"))
                        .frame(width: 8, height: 2)
                        .position(x: w * 0.65, y: h * 0.4)

                case .worried:
                    // Wider eyes
                    Ellipse()
                        .fill(Color(hex: "#1A1A1A"))
                        .frame(width: 7, height: 8)
                        .position(x: w * 0.35, y: h * 0.4)
                    Ellipse()
                        .fill(Color(hex: "#1A1A1A"))
                        .frame(width: 7, height: 8)
                        .position(x: w * 0.65, y: h * 0.4)
                    // Worried eyebrows
                    Path { p in
                        p.move(to: CGPoint(x: w * 0.25, y: h * 0.2))
                        p.addQuadCurve(to: CGPoint(x: w * 0.42, y: h * 0.25), control: CGPoint(x: w * 0.33, y: h * 0.15))
                    }
                    .stroke(Color(hex: "#1A1A1A"), lineWidth: 1.5)
                    Path { p in
                        p.move(to: CGPoint(x: w * 0.75, y: h * 0.2))
                        p.addQuadCurve(to: CGPoint(x: w * 0.58, y: h * 0.25), control: CGPoint(x: w * 0.67, y: h * 0.15))
                    }
                    .stroke(Color(hex: "#1A1A1A"), lineWidth: 1.5)

                default:
                    // Standard/happy eyes
                    let squint = expression == .happy || expression == .celebrating
                    Ellipse()
                        .fill(Color(hex: "#1A1A1A"))
                        .frame(width: 6, height: squint ? 5 : 7)
                        .position(x: w * 0.35, y: h * 0.4)
                    Ellipse()
                        .fill(Color(hex: "#1A1A1A"))
                        .frame(width: 6, height: squint ? 5 : 7)
                        .position(x: w * 0.65, y: h * 0.4)
                }

                // Mouth
                switch expression {
                case .sleeping:
                    EmptyView() // No mouth
                case .worried:
                    // Wavy mouth
                    WavyMouth()
                        .stroke(Color(hex: "#1A1A1A"), lineWidth: 2)
                        .frame(width: w * 0.35, height: 6)
                        .position(x: w * 0.5, y: h * 0.7)
                case .happy, .celebrating:
                    // Wide smile
                    SmileMouth(wide: true)
                        .stroke(Color(hex: "#1A1A1A"), lineWidth: 2)
                        .frame(width: w * 0.4, height: 10)
                        .position(x: w * 0.5, y: h * 0.7)
                case .neutral:
                    // Gentle smile
                    SmileMouth(wide: false)
                        .stroke(Color(hex: "#1A1A1A"), lineWidth: 2)
                        .frame(width: w * 0.35, height: 6)
                        .position(x: w * 0.5, y: h * 0.7)
                }
            }
        }
    }
}

struct SmileMouth: Shape {
    let wide: Bool
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: 0),
            control: CGPoint(x: rect.midX, y: wide ? rect.height * 1.5 : rect.height)
        )
        return path
    }
}

struct WavyMouth: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.midY),
            control1: CGPoint(x: rect.width * 0.33, y: 0),
            control2: CGPoint(x: rect.width * 0.66, y: rect.height)
        )
        return path
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

// MARK: - PriceLevel extension

extension PriceLevel {
    var gnistanExpression: GnistanExpression {
        switch self {
        case .veryCheap, .cheap: return .happy
        case .normal: return .neutral
        case .expensive, .veryExpensive: return .worried
        }
    }
}
