import SwiftUI
import Charts
import ElprisetShared

struct PriceBarChart: View {
    let prices: [TotalPrice]
    var tomorrowPrices: [TotalPrice] = []

    @State private var selectedPrice: TotalPrice?
    @State private var touchLocation: CGPoint?

    var body: some View {
        VStack(spacing: 0) {
            Chart {
                // Today's bars
                ForEach(Array(prices.enumerated()), id: \.offset) { index, price in
                    BarMark(
                        x: .value("Time", price.timeStart),
                        y: .value("Price", price.total.doubleValue)
                    )
                    .foregroundStyle(barColor(for: price))
                    .opacity(price.timeEnd <= .now ? 0.4 : 1.0)
                }

                // Tomorrow's bars (if available)
                ForEach(Array(tomorrowPrices.enumerated()), id: \.offset) { _, price in
                    BarMark(
                        x: .value("Time", price.timeStart),
                        y: .value("Price", price.total.doubleValue)
                    )
                    .foregroundStyle(barColor(for: price))
                    .opacity(0.6)
                }

                // Current time marker
                RuleMark(x: .value("Now", Date.now))
                    .foregroundStyle(Color.elSurfaceDark.opacity(0.6))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4, 3]))

                // Selected price highlight
                if let selected = selectedPrice {
                    RuleMark(x: .value("Selected", selected.timeStart))
                        .foregroundStyle(Color.elSurfaceDark.opacity(0.3))
                        .lineStyle(StrokeStyle(lineWidth: 1))
                }
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
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let origin = geo[proxy.plotFrame!].origin
                                    let location = CGPoint(
                                        x: value.location.x - origin.x,
                                        y: value.location.y - origin.y
                                    )
                                    if let date: Date = proxy.value(atX: location.x) {
                                        let allPrices = prices + tomorrowPrices
                                        if let match = allPrices.first(where: { $0.timeStart <= date && $0.timeEnd > date }) {
                                            if selectedPrice?.timeStart != match.timeStart {
                                                selectedPrice = match
                                                HapticManager.selection()
                                            }
                                        }
                                    }
                                    touchLocation = value.location
                                }
                                .onEnded { _ in
                                    selectedPrice = nil
                                    touchLocation = nil
                                }
                        )
                }
            }
            .frame(height: 220)

            // Tooltip
            if let selected = selectedPrice {
                ChartTooltipView(price: selected)
                    .padding(.top, ElSpacing.sm)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Prisdiagram med \(prices.count) kvartar")
    }

    private func barColor(for price: TotalPrice) -> Color {
        PriceColors.color(for: price.priceLevel)
    }
}
