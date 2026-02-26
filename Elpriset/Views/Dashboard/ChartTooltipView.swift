import SwiftUI
import ElprisetShared

struct ChartTooltipView: View {
    let price: TotalPrice

    var body: some View {
        VStack(spacing: ElSpacing.xs) {
            Text(PriceFormatter.formatSEK(price.total) + " SEK")
                .font(.elDisplaySmall)
                .foregroundStyle(Color.elTextOnDark)
            Text(PriceFormatter.timeRange(start: price.timeStart, end: price.timeEnd))
                .font(.elLabelSmall)
                .foregroundStyle(Color.elTextOnDarkSecondary)
        }
        .padding(.vertical, ElSpacing.sm)
        .padding(.horizontal, ElSpacing.md)
        .background(Color.elSurfaceDark)
        .clipShape(RoundedRectangle(cornerRadius: ElRadius.md))
    }
}
