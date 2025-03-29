import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Text("Impostazioni")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 4)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Tema")
                            .font(.headline)

                        Picker("Tema", selection: $selectedTheme) {
                            ForEach(AppTheme.allCases) { theme in
                                Text(theme.description).tag(theme)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview("Settings Preview") {
    SettingsView()
}
