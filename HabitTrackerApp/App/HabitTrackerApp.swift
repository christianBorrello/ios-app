import SwiftUI

@main
struct HabitTrackerApp: App {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system

    var body: some Scene {
        WindowGroup {
            CustomTabView()
                .preferredColorScheme(selectedTheme.colorScheme)
                .animation(.easeInOut, value: selectedTheme)
        }
    }
}
