import WidgetKit
import SwiftUI

struct LockScreenPriceWidget: Widget {
    let kind = "LockScreenPriceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PriceTimelineProvider()) { entry in
            LockScreenWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Elpris")
        .description("Aktuellt elpris")
        .supportedFamilies([.accessoryCircular])
    }
}

struct LockScreenWidgetView: View {
    let entry: PriceEntry

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()

            Gauge(value: gaugeValue, in: 0...1) {
                Text("")
            } currentValueLabel: {
                Text(formattedPrice)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
            }
            .gaugeStyle(.accessoryCircular)
            .tint(Color.widgetPriceColor(for: entry.priceLevel))
        }
    }

    private var formattedPrice: String {
        let price = NSDecimalNumber(decimal: entry.currentPrice).doubleValue
        return String(format: "%.2f", price).replacingOccurrences(of: ".", with: ",")
    }

    private var gaugeValue: Double {
        // Map price to 0-1 range (0 SEK = 0, 5 SEK = 1)
        let price = NSDecimalNumber(decimal: entry.currentPrice).doubleValue
        return min(max(price / 5.0, 0), 1)
    }
}
