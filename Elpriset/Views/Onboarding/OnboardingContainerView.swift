import SwiftUI
import SwiftData
import ElprisetShared

struct OnboardingContainerView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = OnboardingViewModel()
    @Binding var hasCompletedOnboarding: Bool

    var body: some View {
        TabView(selection: $viewModel.currentPage) {
            OnboardingWelcomeView(viewModel: viewModel)
                .tag(0)

            OnboardingConfirmView(
                viewModel: viewModel,
                onComplete: {
                    saveSettings()
                    hasCompletedOnboarding = true
                }
            )
            .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .background(Color.elBackground)
    }

    private func saveSettings() {
        let descriptor = FetchDescriptor<UserSettings>()
        let settings = (try? modelContext.fetch(descriptor).first) ?? UserSettings()

        settings.priceZone = viewModel.selectedZone.rawValue
        settings.dsoName = viewModel.dsoName ?? ""
        settings.gridFeePerKwh = viewModel.gridFee
        settings.hasCompletedOnboarding = true

        modelContext.insert(settings)
        try? modelContext.save()
    }
}
