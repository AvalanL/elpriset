import SwiftUI
import ElprisetShared

struct SummaryPillView: View {
    let cheapest: TotalPrice
    let mostExpensive: TotalPrice

    var body: some View {
        ElPill {
            HStack(spacing: 0) {
                summaryItem(
                    icon: "bolt.fill",
                    iconColor: .elGreen,
                    label: "Billigast",
                    time: DateFormatters.timeShort.string(from: cheapest.timeStart),
                    price: PriceFormatter.formatSEK(cheapest.total) + " SEK"
                )

                Divider()
                    .frame(height: 32)
                    .background(Color.elSurfaceDarkElevated)

                summaryItem(
                    icon: "exclamationmark.triangle.fill",
                    iconColor: Color(hex: "#E88F8F"),
                    label: "Dyrast",
                    time: DateFormatters.timeShort.string(from: mostExpensive.timeStart),
                    price: PriceFormatter.formatSEK(mostExpensive.total) + " SEK"
                )
            }
        }
    }

    private func summaryItem(icon: String, iconColor: Color, label: String, time: String, price: String) -> some View {
        HStack(spacing: ElSpacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(iconColor)
                .frame(width: 24, height: 24)
                .background(iconColor.opacity(0.15))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: ElSpacing.xxs) {
                Text(label)
                    .font(.elLabelSmall)
                    .foregroundStyle(Color.elTextOnDarkSecondary)
                Text(time)
                    .font(.elLabelMedium)
                    .foregroundStyle(Color.elTextOnDark)
                Text(price)
                    .font(.elLabelSmall)
                    .foregroundStyle(Color.elTextOnDarkSecondary)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
