import SwiftUI
import SwiftData
import ElprisetShared

@main
struct ElprisetApp: App {
    @AppStorage("hasCompletedOnboarding", store: UserDefaults(suiteName: ElectricityConstants.appGroupIdentifier))
    private var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingContainerView(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
        .modelContainer(for: [CachedSpotPrice.self, CachedTariff.self, UserSettings.self])
    }
}
