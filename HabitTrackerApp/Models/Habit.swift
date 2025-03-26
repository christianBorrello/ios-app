import Foundation

struct Habit: Identifiable {
    let id = UUID()
    var name: String
    var emoji: String
    var recurrence: [Weekday] // giorni selezionati
    var completions: [Weekday: Bool] = [:] // stato di completamento per la settimana
    var streak: Int = 0 // giorni consecutivi
}

enum Weekday: Int, CaseIterable, Comparable, Identifiable, Codable {
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday

    var id: Int { rawValue }
    var displayName: String {
        switch self {
        case .monday: return "Lunedì"
        case .tuesday: return "Martedì"
        case .wednesday: return "Mercoledì"
        case .thursday: return "Giovedì"
        case .friday: return "Venerdì"
        case .saturday: return "Sabato"
        case .sunday: return "Domenica"
        }
    }

    var shortSymbol: String {
        switch self {
        case .monday: return "L"
        case .tuesday: return "Ma"
        case .wednesday: return "Me"
        case .thursday: return "G"
        case .friday: return "V"
        case .saturday: return "S"
        case .sunday: return "D"
        }
    }
    
    static func < (lhs: Weekday, rhs: Weekday) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
