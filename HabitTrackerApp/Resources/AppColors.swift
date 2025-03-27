import SwiftUI

struct AppColors {
    // Etichette giorni completati
    static let habitCompleted = Color.green

    // Etichette giorni NON completati
    static let habitPending = Color.cyan.opacity(0.25)

    // Etichetta testo giorni (chiara ma leggibile)
    static let habitLabelText =
        Color.primary
    //Color(red: 50/255, green: 50/255, blue: 50/255)
    //Color(red: 250/255, green: 245/255, blue: 230/255)

    // Colore di sfondo delle card non completate
    static let habitCardBackground = Color.yellow.opacity(0.3)

    // Colore di riempimento progressivo
    static let habitProgressFill = Color.green.opacity(0.3)

    // Effetto luce sopra il riempimento
    static let habitProgressOverlay = LinearGradient(
        gradient: Gradient(colors: [
            Color.white.opacity(0.05),
            Color.white.opacity(0.1)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )

    // Etichetta laterale "Abitudine"
    static let habitLabel = Color.purple
}
