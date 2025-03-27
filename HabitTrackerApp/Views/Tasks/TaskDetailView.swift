import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var task: TaskItem
    var onSave: (TaskItem) -> Void
    var onDelete: (TaskItem) -> Void
    
    var body: some View {
        Form {
            Section(header: Text("Emoji")) {
                TextField("Emoji", text: $task.emoji)
            }
            Section(header: Text("Nome")) {
                TextField("Nome", text: $task.title)
            }
            Section(header: Text("Descrizione")) {
                TextField("Descrizione", text: $task.description)
            }
            Section(header: Text("Scadenza")) {
                DatePicker("Data", selection: $task.dueDate, displayedComponents: .date)
            }
            Section {
                Button("Elimina task", role: .destructive) {
                    onDelete(task)
                    dismiss()
                }
            }
        }
        .navigationTitle("Modifica Task")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Salva") {
                    onSave(task)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    TaskDetailView(
        task: TaskItem(emoji: "📚", title: "Studiare", description: "Capitolo 4", dueDate: Date()),
        onSave: { _ in },
        onDelete: { _ in }
    )
}
