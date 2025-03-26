import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            TasksView()
                .tabItem { Label("Task", systemImage: "checkmark.circle") }
            HabitsView()
                .tabItem { Label("Abitudini", systemImage: "repeat") }
            ProgressView()
                .tabItem { Label("Progressi", systemImage: "chart.bar") }
            SettingsView()
                .tabItem { Label("Impostazioni", systemImage: "gearshape") }
        }
    }
}

#Preview {
    MainTabView()
}
