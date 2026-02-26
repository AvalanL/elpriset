import WidgetKit
import SwiftUI
import Charts

struct LargePriceWidget: Widget {
    let kind = "LargePriceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PriceTimelineProvider()) { entry in
            LargeWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Elpriset Stor")
        .description("Fullständigt prisdiagram")
        .supportedFamilies([.systemLarge])
    }
}

struct LargeWidgetView: View {
    let entry: PriceEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header
            HStack {
                Text("Elpriset")
                    .font(.system(size: 13, weight: .medium))
                Spacer()
                Text(entry.priceZone)
                    .font(.system(size: 11, weight: .medium))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.wSurfaceDark)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }

            // Price
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(formattedPrice)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                Text("SEK/kWh")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
            }

            // Chart
            if !entry.todayPrices.isEmpty {
                Chart(Array(entry.todayPrices.enumerated()), id: \.offset) { _, price in
                    BarMark(
                        x: .value("Time", price.timeStart),
                        y: .value("Price", price.price)
                    )
                    .foregroundStyle(Color.widgetPriceColor(for: price.level))
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .hour, count: 6)) { value in
                        AxisValueLabel {
                            if let date = value.as(Date.self) {
                                let formatter = DateFormatter()
                                let _ = formatter.dateFormat = "HH"
                                Text(formatter.string(from: date))
                                    .font(.system(size: 10))
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    }
                }
                .chartYAxis(.hidden)
                .frame(maxHeight: .infinity)
            }

            Spacer(minLength: 0)

            // Bottom cheapest pill
            if let cheapestTime = entry.cheapestTime,
               let cheapestPrice = entry.cheapestPrice {
                let priceStr = String(format: "%.2f", NSDecimalNumber(decimal: cheapestPrice).doubleValue).replacingOccurrences(of: ".", with: ",")
                HStack(spacing: 4) {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(Color.wGreen)
                    Text("Billigast kvar: \(cheapestTime) – \(priceStr) SEK")
                        .font(.system(size: 11, weight: .medium))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.wSurfaceDark)
                .foregroundStyle(.white)
                .clipShape(Capsule())
            }
        }
        .padding(16)
    }

    private var formattedPrice: String {
        let price = NSDecimalNumber(decimal: entry.currentPrice).doubleValue
        return String(format: "%.2f", price).replacingOccurrences(of: ".", with: ",")
    }
}
