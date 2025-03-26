import SwiftUI

@main
struct HabitJourneyApp: App {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(selectedTheme.colorScheme)
        }
    }
}
