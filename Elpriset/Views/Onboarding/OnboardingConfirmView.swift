import SwiftUI
import ElprisetShared

struct OnboardingConfirmView: View {
    let viewModel: OnboardingViewModel
    let onComplete: () -> Void

    var body: some View {
        VStack(spacing: ElSpacing.xl) {
            Spacer()

            // Zone detection result
            VStack(spacing: ElSpacing.md) {
                Image(systemName: "location.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(Color.elGreen)

                if let zone = viewModel.detectedZone {
                    Text("Du är i \(zone.displayName)")
                        .font(.elHeadingMedium)
                        .foregroundStyle(Color.elTextPrimary)
                } else {
                    Text("Välj ditt elområde")
                        .font(.elHeadingMedium)
                        .foregroundStyle(Color.elTextPrimary)
                }

                if let dso = viewModel.dsoName {
                    Text("Nätägare: \(dso)")
                        .font(.elBodyMedium)
                        .foregroundStyle(Color.elTextSecondary)
                }
            }

            // Zone picker
            Picker("Elområde", selection: Binding(
                get: { viewModel.selectedZone },
                set: { viewModel.selectedZone = $0 }
            )) {
                ForEach(PriceZone.allCases) { zone in
                    Text(zone.displayName).tag(zone)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, ElSpacing.base)

            // Live price "aha moment"
            if let price = viewModel.livePrice {
                ElCard(style: .lavender) {
                    VStack(spacing: ElSpacing.md) {
                        Text("Just nu kostar din el:")
                            .font(.elBodyMedium)
                            .foregroundStyle(Color.elTextSecondary)

                        HStack(alignment: .firstTextBaseline, spacing: ElSpacing.xs) {
                            Text(PriceFormatter.formatSEK(price.total))
                                .font(.elDisplayHero)
                                .foregroundStyle(Color.elTextPrimary)
                            Text("SEK/kWh")
                                .font(.elUnit)
                                .foregroundStyle(Color.elTextSecondary)
                        }

                        // Cost breakdown
                        VStack(spacing: ElSpacing.xs) {
                            breakdownRow("Spotpris", PriceFormatter.formatOre(price.spotPrice) + " öre")
                            breakdownRow("Nätavgift", PriceFormatter.formatOre(price.gridFee) + " öre")
                            breakdownRow("Energiskatt", PriceFormatter.formatOre(price.electricityTax) + " öre")
                            breakdownRow("Moms (25%)", "= \(PriceFormatter.formatSEK(price.total)) SEK")
                        }
                    }
                }
                .padding(.horizontal, ElSpacing.base)
            } else if viewModel.isDetectingLocation {
                ProgressView("Hämtar elpris...")
                    .foregroundStyle(Color.elTextSecondary)
            }

            Spacer()

            // Pagination dots
            HStack(spacing: ElSpacing.sm) {
                Circle().fill(Color.elBackgroundTertiary).frame(width: 8, height: 8)
                Circle().fill(Color.elGreen).frame(width: 8, height: 8)
            }

            ElButton("Fortsätt") {
                onComplete()
            }
            .padding(.horizontal, ElSpacing.base)
            .padding(.bottom, ElSpacing.xxl)
        }
        .background(Color.elBackground)
    }

    private func breakdownRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .font(.elBodySmall)
                .foregroundStyle(Color.elTextSecondary)
            Spacer()
            Text(value)
                .font(.elLabelMedium)
                .foregroundStyle(Color.elTextPrimary)
        }
    }
}
