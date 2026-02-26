import SwiftUI
import Charts
import ElprisetShared

struct PriceLineChart: View {
    let prices: [TotalPrice]

    @State private var selectedPrice: TotalPrice?

    var body: some View {
        Chart {
            ForEach(Array(prices.enumerated()), id: \.offset) { _, price in
                AreaMark(
                    x: .value("Time", price.timeStart),
                    y: .value("Price", price.total.doubleValue)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.elLavender.opacity(0.3), Color.elLavender.opacity(0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .interpolationMethod(.catmullRom)

                LineMark(
                    x: .value("Time", price.timeStart),
                    y: .value("Price", price.total.doubleValue)
                )
                .foregroundStyle(Color.elSurfaceDark)
                .lineStyle(StrokeStyle(lineWidth: 2.5))
                .interpolationMethod(.catmullRom)
            }

            RuleMark(x: .value("Now", Date.now))
                .foregroundStyle(Color.elSurfaceDark.opacity(0.6))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4, 3]))
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour, count: 3)) { value in
                AxisValueLabel {
                    if let date = value.as(Date.self) {
                        Text(DateFormatters.timeShort.string(from: date))
                            .font(.elBodySmall)
                            .foregroundStyle(Color.elTextTertiary)
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4, 3]))
                    .foregroundStyle(Color.elBackgroundTertiary)
                AxisValueLabel {
                    if let val = value.as(Double.self) {
                        Text(String(format: "%.1f", val))
                            .font(.elBodySmall)
                            .foregroundStyle(Color.elTextTertiary)
                    }
                }
            }
        }
        .frame(height: 220)
    }
}
