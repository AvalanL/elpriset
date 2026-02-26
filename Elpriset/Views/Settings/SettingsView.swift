import SwiftUI
import SwiftData
import ElprisetShared

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = SettingsViewModel()
    @State private var showPaywall = false

    var body: some View {
        NavigationStack {
            List {
                // Price Zone
                Section("Elområde") {
                    Picker("Priszon", selection: $viewModel.priceZone) {
                        ForEach(PriceZone.allCases) { zone in
                            Text(zone.fullDescription).tag(zone)
                        }
                    }
                }

                // Grid Operator
                Section("Nätägare") {
                    HStack {
                        Text("Nätägare")
                        Spacer()
                        Text(viewModel.dsoName.isEmpty ? "Ej vald" : viewModel.dsoName)
                            .foregroundStyle(Color.elTextSecondary)
                    }
                }

                // Display
                Section("Visning") {
                    Toggle("Visa i öre/kWh", isOn: $viewModel.showOrePerKwh)
                    Toggle("Inkludera moms", isOn: $viewModel.includeVAT)
                    Toggle("Inkludera nätavgift", isOn: $viewModel.includeGridFee)
                    Toggle("Tillgängliga färger", isOn: $viewModel.useAccessibleColors)
                }

                // Mascot
                Section("Gnistan") {
                    Toggle("Visa Gnistan i appen", isOn: $viewModel.showGnistan)
                    Toggle("Visa Gnistan i notiser", isOn: $viewModel.showGnistanInNotifications)
                }

                // Subscription
                Section {
                    Button("Elpriset Pro") {
                        showPaywall = true
                    }
                    .foregroundStyle(Color.elGreenDark)
                }

                // About
                Section("Om") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(Color.elTextSecondary)
                    }
                }
            }
            .navigationTitle("Inställningar")
            .tint(.elGreen)
            .onAppear { viewModel.load(from: modelContext) }
            .onChange(of: viewModel.priceZone) { _, _ in viewModel.save(to: modelContext) }
            .onChange(of: viewModel.showOrePerKwh) { _, _ in viewModel.save(to: modelContext) }
            .onChange(of: viewModel.includeVAT) { _, _ in viewModel.save(to: modelContext) }
            .onChange(of: viewModel.includeGridFee) { _, _ in viewModel.save(to: modelContext) }
            .onChange(of: viewModel.useAccessibleColors) { _, _ in viewModel.save(to: modelContext) }
            .onChange(of: viewModel.showGnistan) { _, _ in viewModel.save(to: modelContext) }
            .onChange(of: viewModel.showGnistanInNotifications) { _, _ in viewModel.save(to: modelContext) }
            .sheet(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }
}
