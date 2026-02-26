import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = PaywallViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: ElSpacing.xxl) {
                // Close button
                HStack {
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.elTextSecondary)
                            .frame(width: 32, height: 32)
                            .background(Color.elBackgroundSecondary)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, ElSpacing.base)

                // Icon + title
                VStack(spacing: ElSpacing.sm) {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(Color.elGreen)

                    Text("Elpriset Pro")
                        .font(.elHeadingLarge)
                        .foregroundStyle(Color.elTextPrimary)

                    Text("Se din totalkostnad\nvarje dag")
                        .font(.elBodyLarge)
                        .foregroundStyle(Color.elTextSecondary)
                        .multilineTextAlignment(.center)
                }

                // Features
                VStack(alignment: .leading, spacing: ElSpacing.md) {
                    ForEach(viewModel.features, id: \.self) { feature in
                        HStack(spacing: ElSpacing.md) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(Color.elGreen)
                            Text(feature)
                                .font(.elBodyMedium)
                                .foregroundStyle(Color.elTextPrimary)
                        }
                    }
                }
                .padding(.horizontal, ElSpacing.base)

                // Pricing tiers
                VStack(spacing: ElSpacing.xs) {
                    ForEach(SubscriptionTier.allCases) { tier in
                        pricingCard(tier: tier)
                    }
                }
                .padding(.horizontal, ElSpacing.base)

                // CTA
                ElButton("Prova gratis i 3 dagar") {
                    Task { await viewModel.purchase() }
                }
                .padding(.horizontal, ElSpacing.base)

                // Restore + links
                VStack(spacing: ElSpacing.sm) {
                    Button("Återställ köp") {
                        Task { await viewModel.restorePurchases() }
                    }
                    .font(.elBodySmall)
                    .foregroundStyle(Color.elTextSecondary)

                    HStack(spacing: ElSpacing.sm) {
                        Text("Villkor")
                        Text("•")
                        Text("Integritet")
                    }
                    .font(.elBodySmall)
                    .foregroundStyle(Color.elTextTertiary)
                }
                .padding(.bottom, ElSpacing.xxl)
            }
        }
        .background(Color.elBackground)
    }

    private func pricingCard(tier: SubscriptionTier) -> some View {
        Button {
            withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
                viewModel.selectedTier = tier
            }
        } label: {
            HStack {
                // Radio button
                Circle()
                    .strokeBorder(
                        viewModel.selectedTier == tier ? Color.elGreen : .elBackgroundTertiary,
                        lineWidth: viewModel.selectedTier == tier ? 6 : 1
                    )
                    .frame(width: 22, height: 22)

                Text(tier.label)
                    .font(.elLabelLarge)
                    .foregroundStyle(Color.elTextPrimary)

                Spacer()

                VStack(alignment: .trailing, spacing: ElSpacing.xxs) {
                    Text(tier.price)
                        .font(.elLabelLarge)
                        .foregroundStyle(Color.elTextPrimary)
                    if let sub = tier.subtitle {
                        Text(sub)
                            .font(.elLabelSmall)
                            .foregroundStyle(Color.elGreenDark)
                    }
                }

                if tier.isBestValue {
                    Text("BÄST VÄRDE")
                        .font(.elLabelSmall)
                        .foregroundStyle(Color.elGreenDark)
                        .padding(.horizontal, ElSpacing.sm)
                        .padding(.vertical, ElSpacing.xs)
                        .background(Color.elGreenLight)
                        .clipShape(Capsule())
                }
            }
            .padding(ElSpacing.base)
            .background(
                viewModel.selectedTier == tier
                    ? Color.elGreenLight.opacity(0.3)
                    : Color.elBackground
            )
            .clipShape(RoundedRectangle(cornerRadius: ElRadius.md))
            .overlay(
                RoundedRectangle(cornerRadius: ElRadius.md)
                    .stroke(
                        viewModel.selectedTier == tier ? Color.elGreen : .elBackgroundTertiary,
                        lineWidth: viewModel.selectedTier == tier ? 2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
    }
}
