import Foundation
import SwiftUI

class TasksViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []

    init() {
        loadMockTasks()
    }

    func addTask(_ task: TaskItem) {
        tasks.append(task)
    }

    func loadMockTasks() {
        tasks = [
            TaskItem(emoji: "📚", title: "Studiare Swift", description: "Modulo 3", dueDate: Date()),
            TaskItem(emoji: "🏃‍♂️", title: "Allenamento", description: "Corsa 30min", dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!)
        ]
    }

    var todayTasks: [TaskItem] {
        tasks.filter { Calendar.current.isDateInToday($0.dueDate) }
    }

    var upcomingTasks: [TaskItem] {
        tasks.filter { !$0.dueDate.isToday }
    }
}
