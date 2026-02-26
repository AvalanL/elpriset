import WidgetKit
import SwiftUI

struct SmallPriceWidget: Widget {
    let kind = "SmallPriceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PriceTimelineProvider()) { entry in
            SmallWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Elpriset")
        .description("Aktuellt elpris med sparkline")
        .supportedFamilies([.systemSmall])
    }
}

struct SmallWidgetView: View {
    let entry: PriceEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Elpriset")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
                Circle()
                    .fill(Color.widgetPriceColor(for: entry.priceLevel))
                    .frame(width: 8, height: 8)
            }

            Spacer()

            Text(formattedPrice)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .minimumScaleFactor(0.6)

            Text("SEK/kWh")
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.tertiary)

            Spacer()

            // Sparkline
            if !entry.todayPrices.isEmpty {
                WidgetSparkline(prices: entry.todayPrices)
                    .frame(height: 40)
            }
        }
        .padding(12)
    }

    private var formattedPrice: String {
        let price = NSDecimalNumber(decimal: entry.currentPrice).doubleValue
        return String(format: "%.2f", price).replacingOccurrences(of: ".", with: ",")
    }
}
