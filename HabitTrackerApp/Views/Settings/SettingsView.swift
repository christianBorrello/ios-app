import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tema")) {
                    Picker("Tema", selection: $selectedTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.description).tag(theme)
                        }
                    }
                }
            }
            .navigationTitle("Impostazioni")
        }
    }
}

#Preview("Settings Preview") {
    SettingsView()
}
