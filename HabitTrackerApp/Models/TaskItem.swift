import Foundation

struct TaskItem: Identifiable {
    let id = UUID()
    var emoji: String
    var title: String
    var description: String
    var dueDate: Date
    var isCompleted: Bool = false
}
