import SwiftUI

enum TabItem: Int, CaseIterable, Identifiable {
    case home, tasks, habits, progress, settings

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .tasks: return "Task"
        case .habits: return "Abitudini"
        case .progress: return "Progressi"
        case .settings: return "Impostazioni"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house"
        case .tasks: return "checkmark.circle"
        case .habits: return "repeat"
        case .progress: return "chart.bar"
        case .settings: return "gearshape"
        }
    }
}
