import SwiftUI

struct OnboardingWelcomeView: View {
    let viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 0) {
            // Top white section
            VStack(spacing: ElSpacing.xxl) {
                Spacer()

                // Hero image placeholder
                RoundedRectangle(cornerRadius: ElRadius.xl)
                    .fill(Color.elLavender)
                    .frame(height: 260)
                    .overlay {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(Color.elGreen)
                    }
                    .padding(.horizontal, ElSpacing.base)

                VStack(alignment: .leading, spacing: ElSpacing.base) {
                    Text("Se vad din el\nverkligen kostar —\ninte bara spotpriset")
                        .font(.elHeadingLarge)
                        .foregroundStyle(Color.elTextPrimary)
                        .lineSpacing(4)

                    // Pagination dots
                    HStack(spacing: ElSpacing.sm) {
                        Circle().fill(Color.elGreen).frame(width: 8, height: 8)
                        Circle().fill(Color.elBackgroundTertiary).frame(width: 8, height: 8)
                    }
                }
                .padding(.horizontal, ElSpacing.base)
            }

            // Dark bottom section with curve
            DarkCurvedSection {
                VStack(spacing: ElSpacing.lg) {
                    Text("Svep uppåt för att börja")
                        .font(.elBodyMedium)
                        .foregroundStyle(Color.elTextOnDarkSecondary)

                    ElButton("Visa mitt elpris", icon: "location.fill") {
                        Task {
                            await viewModel.detectLocation()
                            withAnimation { viewModel.currentPage = 1 }
                        }
                    }
                    .padding(.horizontal, ElSpacing.xxl)

                    Button("Välj manuellt") {
                        withAnimation { viewModel.currentPage = 1 }
                    }
                    .font(.elLabelLarge)
                    .foregroundStyle(Color.elTextOnDarkSecondary)
                }
                .padding(.bottom, ElSpacing.xxxl)
            }
            .frame(height: 220)
        }
    }
}

struct DarkCurvedSection<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        ZStack(alignment: .top) {
            CurvedTop()
                .fill(Color.elSurfaceDark)

            content()
                .padding(.top, ElSpacing.xxxl)
        }
    }
}

struct CurvedTop: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 40))
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: 40),
            control: CGPoint(x: rect.midX, y: 0)
        )
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}
