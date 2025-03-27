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

    func updateTask(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }

    func deleteTask(_ task: TaskItem) {
        tasks.removeAll { $0.id == task.id }
    }

    func toggleCompletion(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
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
