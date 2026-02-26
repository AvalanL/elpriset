import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tag(0)
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                }

            SearchView()
                .tag(1)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }

            HistoryView()
                .tag(2)
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "chart.bar.fill" : "chart.bar")
                }

            SettingsView()
                .tag(3)
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "person.fill" : "person")
                }
        }
        .tint(.elTextPrimary)
    }
}
