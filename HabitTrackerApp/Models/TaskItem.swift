import Foundation

struct TaskItem: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let description: String
    let dueDate: Date
}
