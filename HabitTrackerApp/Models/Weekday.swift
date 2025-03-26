enum Weekday: Int, CaseIterable, Comparable, Identifiable, Codable, Hashable {
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday

    var id: Int { rawValue }
    var fullName: String {
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
