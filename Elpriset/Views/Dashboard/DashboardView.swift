import SwiftUI
import SwiftData
import ElprisetShared

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = DashboardViewModel()
    @State private var settings = SettingsViewModel()
    @State private var showSettings = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ElSpacing.lg) {
                // Header
                headerSection

                // Loading / Error
                if viewModel.isLoading && viewModel.todayTotalPrices.isEmpty {
                    ProgressView("Hämtar priser...")
                        .frame(maxWidth: .infinity, minHeight: 200)
                }

                if let error = viewModel.error, viewModel.todayTotalPrices.isEmpty {
                    errorView(error)
                }

                // Hero Price Card
                HeroPriceCard(
                    currentPrice: viewModel.currentPrice,
                    trendPercentage: viewModel.trendPercentage,
                    lastUpdated: viewModel.lastUpdated
                )

                // Chart Section
                chartSection

                // Summary Pill
                if let cheapest = viewModel.cheapestRemaining,
                   let expensive = viewModel.mostExpensiveRemaining {
                    SummaryPillView(cheapest: cheapest, mostExpensive: expensive)
                }

                // Smart Tips
                if !viewModel.tips.isEmpty {
                    SmartTipsView(tips: viewModel.tips)
                }
            }
            .padding(.horizontal, ElSpacing.base)
            .padding(.bottom, ElSpacing.xxl)
        }
        .background(Color.elBackground)
        .refreshable {
            await fetchRealData()
        }
        .task {
            settings.load(from: modelContext)
            await fetchRealData()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }

    private func fetchRealData() async {
        await viewModel.loadPrices(
            zone: settings.priceZone,
            gridFee: settings.gridFeePerKwh,
            includeVAT: settings.includeVAT,
            includeGridFee: settings.includeGridFee
        )
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: ElSpacing.md) {
            GnistanView(expression: .worried, size: 48)
            Text("Gnistan hittar inga priser just nu.")
                .font(.elBodyMedium)
                .foregroundStyle(Color.elTextSecondary)
            Text(message)
                .font(.elBodySmall)
                .foregroundStyle(Color.elTextTertiary)
            ElButton("Försök igen", style: .secondary) {
                Task { await fetchRealData() }
            }
            .frame(width: 160)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: ElSpacing.xs) {
                Text("Elpriset")
                    .font(.elHeadingLarge)
                    .foregroundStyle(Color.elTextPrimary)
                Text(DateFormatters.dayOfWeek.string(from: .now).capitalized)
                    .font(.elBodyMedium)
                    .foregroundStyle(Color.elTextSecondary)
            }
            Spacer()
            Button { showSettings = true } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 24))
                    .foregroundStyle(Color.elTextSecondary)
            }
        }
        .padding(.top, ElSpacing.base)
    }

    private var chartSection: some View {
        VStack(alignment: .leading, spacing: ElSpacing.sm) {
            HStack {
                Text("Idag")
                    .font(.elHeadingMedium)
                    .foregroundStyle(Color.elTextPrimary)
                Spacer()
                ElSegmentedControl(
                    items: ["Staplar", "Linje"],
                    selectedIndex: $viewModel.selectedChartType
                )
                .frame(width: 160)
            }

            if viewModel.selectedChartType == 0 {
                PriceBarChart(
                    prices: viewModel.todayTotalPrices,
                    tomorrowPrices: viewModel.tomorrowTotalPrices
                )
            } else {
                PriceLineChart(prices: viewModel.todayTotalPrices)
            }
        }
    }
}
