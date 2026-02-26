import SwiftUI
import Charts
import ElprisetShared

struct HistoryView: View {
    @State private var viewModel = HistoryViewModel()

    private let periodLabels = ["Dag", "Vecka", "Månad", "År"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ElSpacing.lg) {
                // Header
                VStack(alignment: .leading, spacing: ElSpacing.xs) {
                    Text("Prishistorik")
                        .font(.elHeadingLarge)
                        .foregroundStyle(Color.elTextPrimary)
                    Text("Din elkonsumtionsrapport")
                        .font(.elBodyMedium)
                        .foregroundStyle(Color.elTextSecondary)
                }
                .padding(.top, ElSpacing.base)

                // Segmented control
                ElSegmentedControl(
                    items: periodLabels,
                    selectedIndex: $viewModel.selectedPeriod
                )

                // Monthly bar chart
                if !viewModel.monthlyStats.isEmpty {
                    MonthlyBarChart(stats: Array(viewModel.monthlyStats))
                }

                // Summary pill
                ElPill {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Denna vecka")
                                .font(.elLabelSmall)
                                .foregroundStyle(Color.elTextOnDarkSecondary)
                            Text("93 kWh")
                                .font(.elDisplaySmall)
                                .foregroundStyle(Color.elTextOnDark)
                        }
                        .frame(maxWidth: .infinity)

                        Divider()
                            .frame(height: 32)
                            .background(Color.elSurfaceDarkElevated)

                        VStack(alignment: .leading) {
                            Text("Denna månad")
                                .font(.elLabelSmall)
                                .foregroundStyle(Color.elTextOnDarkSecondary)
                            Text("793 kWh")
                                .font(.elDisplaySmall)
                                .foregroundStyle(Color.elTextOnDark)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }

                // Stats grid
                Text("Statistik")
                    .font(.elHeadingMedium)
                    .foregroundStyle(Color.elTextPrimary)

                StatCardGrid()
            }
            .padding(.horizontal, ElSpacing.base)
            .padding(.bottom, ElSpacing.xxl)
        }
        .background(Color.elBackground)
        .task {
            viewModel.loadMockHistory()
        }
    }
}

// MARK: - Monthly Bar Chart

struct MonthlyBarChart: View {
    let stats: [HistoryViewModel.MonthStat]

    var body: some View {
        Chart(stats) { stat in
            BarMark(
                x: .value("Month", stat.month),
                y: .value("Average", stat.average.doubleValue)
            )
            .foregroundStyle(
                LinearGradient(
                    colors: [Color.elGreenLight, Color.elGreen],
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            .cornerRadius(6)
        }
        .chartXAxis {
            AxisMarks { value in
                AxisValueLabel {
                    if let month = value.as(String.self) {
                        Text(month)
                            .font(.elBodySmall)
                            .foregroundStyle(Color.elTextSecondary)
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
        .frame(height: 200)
    }
}

// MARK: - Stat Card Grid

struct StatCardGrid: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: ElSpacing.md), GridItem(.flexible())], spacing: ElSpacing.md) {
            statCard(
                style: .green,
                title: "Elkostnad",
                subtitle: "Årlig",
                value: "4 982 SEK",
                trend: "+6,2%",
                trendPositive: false
            )
            statCard(
                style: .bordered,
                title: "Förbrukning",
                subtitle: "Månad",
                value: "250 kWh",
                trend: "-2,3%",
                trendPositive: true
            )
        }
    }

    private func statCard(style: ElCardStyle, title: String, subtitle: String, value: String, trend: String, trendPositive: Bool) -> some View {
        ElCard(style: style) {
            VStack(alignment: .leading, spacing: ElSpacing.sm) {
                Text(title)
                    .font(.elLabelMedium)
                    .foregroundStyle(style == .green ? Color.elTextOnGreen : .elTextSecondary)
                Text(subtitle)
                    .font(.elLabelSmall)
                    .foregroundStyle(style == .green ? Color.elTextOnGreen.opacity(0.7) : .elTextTertiary)
                Text(value)
                    .font(.elDisplayMedium)
                    .foregroundStyle(style == .green ? Color.elTextOnGreen : .elTextPrimary)
                HStack(spacing: ElSpacing.xxs) {
                    Image(systemName: trendPositive ? "arrow.down.right" : "arrow.up.right")
                    Text(trend)
                }
                .font(.elLabelSmall)
                .foregroundStyle(trendPositive ? Color.elPositive : .elNegative)
            }
        }
    }
}
