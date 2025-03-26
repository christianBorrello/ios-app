import SwiftUI

struct ProgressView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Grafici e Statistiche")
                    .font(.title)
                // Aggiungi grafici o statistiche per visualizzare i progressi
            }
            .navigationTitle("Progressi")
        }
    }
}

#Preview("Progress Preview") {
    ProgressView()
}
