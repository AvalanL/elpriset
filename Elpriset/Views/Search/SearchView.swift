import SwiftUI
import ElprisetShared

struct SearchView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: ElSpacing.lg) {
                    Text("Jämför elområden")
                        .font(.elHeadingLarge)
                        .foregroundStyle(Color.elTextPrimary)
                        .padding(.top, ElSpacing.base)

                    Text("Se aktuella priser i alla fyra elområden")
                        .font(.elBodyMedium)
                        .foregroundStyle(Color.elTextSecondary)

                    ForEach(PriceZone.allCases) { zone in
                        zoneCard(zone: zone)
                    }
                }
                .padding(.horizontal, ElSpacing.base)
                .padding(.bottom, ElSpacing.xxl)
            }
            .background(Color.elBackground)
        }
    }

    private func zoneCard(zone: PriceZone) -> some View {
        ElCard(style: .bordered) {
            HStack {
                VStack(alignment: .leading, spacing: ElSpacing.xs) {
                    Text(zone.displayName)
                        .font(.elHeadingSmall)
                        .foregroundStyle(Color.elTextPrimary)
                    Text(zone.fullDescription)
                        .font(.elBodySmall)
                        .foregroundStyle(Color.elTextSecondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.elTextTertiary)
            }
        }
    }
}
