import SwiftUI
import ElprisetShared

struct HeroPriceCard: View {
    let currentPrice: TotalPrice?
    let trendPercentage: Decimal?
    let lastUpdated: Date?

    var body: some View {
        ElCard(style: .lavender) {
            VStack(alignment: .leading, spacing: ElSpacing.md) {
                HStack {
                    VStack(alignment: .leading, spacing: ElSpacing.xs) {
                        Text("Aktuellt elpris")
                            .font(.elHeadingSmall)
                            .foregroundStyle(Color.elTextPrimary)
                        if let lastUpdated {
                            Text("Uppdaterat \(DateFormatters.timeShort.string(from: lastUpdated))")
                                .font(.elBodySmall)
                                .foregroundStyle(Color.elTextSecondary)
                        }
                    }
                    Spacer()
                    ElIconContainer("bolt.fill", size: .hero)
                }

                if let price = currentPrice {
                    // Hero price number
                    HStack(alignment: .firstTextBaseline, spacing: ElSpacing.xs) {
                        Text(PriceFormatter.formatSEK(price.total))
                            .font(.elDisplayHero)
                            .foregroundStyle(Color.elTextPrimary)
                            .contentTransition(.numericText())
                        Text("SEK/kWh")
                            .font(.elUnit)
                            .foregroundStyle(Color.elTextSecondary)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Aktuellt elpris: \(PriceFormatter.formatSEK(price.total)) kronor per kilowattimme. Prisnivå: \(price.priceLevel.label)")

                    // Cost breakdown
                    Text("Spot \(PriceFormatter.formatOre(price.spotPrice)) + Nät \(PriceFormatter.formatOre(price.gridFee)) + Skatt \(PriceFormatter.formatOre(price.electricityTax)) öre")
                        .font(.elBodySmall)
                        .foregroundStyle(Color.elTextSecondary)

                    // Trend
                    if let trend = trendPercentage {
                        HStack(spacing: ElSpacing.xs) {
                            Image(systemName: trend >= 0 ? "arrow.up.right" : "arrow.down.right")
                            Text("\(abs(trend.doubleValue), specifier: "%.1f")% vs igår")
                        }
                        .font(.elLabelMedium)
                        .foregroundStyle(trend >= 0 ? Color.elNegative : .elPositive)
                    }
                } else {
                    Text("Laddar...")
                        .font(.elDisplayLarge)
                        .foregroundStyle(Color.elTextTertiary)
                }
            }
        }
    }
}
