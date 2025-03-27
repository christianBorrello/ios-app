import Foundation

struct Habit: Identifiable {
    let id = UUID()
    var name: String
    var emoji: String
    var recurrence: [Weekday] // giorni selezionati
    var completions: [Weekday: Bool] = [:] // stato di completamento per la settimana
    var streak: Int = 0 // giorni consecutivi
    var time: Date? = nil
}

