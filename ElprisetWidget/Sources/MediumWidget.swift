import WidgetKit
import SwiftUI
import Charts

struct MediumPriceWidget: Widget {
    let kind = "MediumPriceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PriceTimelineProvider()) { entry in
            MediumWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Elpriset Medium")
        .description("Aktuellt pris med stapeldiagram")
        .supportedFamilies([.systemMedium])
    }
}

struct MediumWidgetView: View {
    let entry: PriceEntry

    var body: some View {
        HStack(spacing: 16) {
            // Left: price info
            VStack(alignment: .leading, spacing: 4) {
                Text("Just nu")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)

                Text(formattedPrice)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .minimumScaleFactor(0.6)

                Text("SEK/kWh")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.tertiary)

                Spacer()

                if let cheapestTime = entry.cheapestTime,
                   let cheapestPrice = entry.cheapestPrice {
                    let priceStr = String(format: "%.2f", NSDecimalNumber(decimal: cheapestPrice).doubleValue).replacingOccurrences(of: ".", with: ",")
                    Text("Billigast: \(cheapestTime) (\(priceStr))")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Right: mini bar chart
            if !entry.todayPrices.isEmpty {
                WidgetBarChart(prices: entry.todayPrices)
            }
        }
        .padding(16)
    }

    private var formattedPrice: String {
        let price = NSDecimalNumber(decimal: entry.currentPrice).doubleValue
        return String(format: "%.2f", price).replacingOccurrences(of: ".", with: ",")
    }
}

struct WidgetBarChart: View {
    let prices: [PriceEntry.WidgetPrice]

    var body: some View {
        Chart(Array(prices.enumerated()), id: \.offset) { _, price in
            BarMark(
                x: .value("Time", price.timeStart),
                y: .value("Price", price.price)
            )
            .foregroundStyle(Color.widgetPriceColor(for: price.level))
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(maxWidth: .infinity)
    }
}
