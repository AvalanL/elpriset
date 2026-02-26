import SwiftUI
import Charts

struct WidgetSparkline: View {
    let prices: [PriceEntry.WidgetPrice]

    var body: some View {
        Chart(Array(prices.enumerated()), id: \.offset) { _, price in
            LineMark(
                x: .value("Time", price.timeStart),
                y: .value("Price", price.price)
            )
            .foregroundStyle(Color.wGreen)
            .lineStyle(StrokeStyle(lineWidth: 1.5))
            .interpolationMethod(.catmullRom)

            AreaMark(
                x: .value("Time", price.timeStart),
                y: .value("Price", price.price)
            )
            .foregroundStyle(
                LinearGradient(
                    colors: [Color.wGreen.opacity(0.2), Color.wGreen.opacity(0)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .interpolationMethod(.catmullRom)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}
