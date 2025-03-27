import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let originalTask: TaskItem
    @State private var editedTask: TaskItem
    @State private var showDeleteConfirmation = false

    var onSave: (TaskItem) -> Void
    var onDelete: (TaskItem) -> Void

    init(task: TaskItem, onSave: @escaping (TaskItem) -> Void, onDelete: @escaping (TaskItem) -> Void) {
        self.originalTask = task
        self._editedTask = State(initialValue: task)
        self.onSave = onSave
        self.onDelete = onDelete
    }

    var body: some View {
        Form {
            Section(header: Text("Emoji")) {
                TextField("Emoji", text: $editedTask.emoji)
            }

            Section(header: Text("Nome")) {
                TextField("Nome", text: $editedTask.title)
            }

            Section(header: Text("Descrizione")) {
                TextField("Descrizione", text: $editedTask.description)
            }

            Section(header: Text("Scadenza")) {
                DatePicker("Data e ora", selection: $editedTask.dueDate, displayedComponents: [.date, .hourAndMinute])
            }

            Section {
                Button("Elimina task", role: .destructive) {
                    showDeleteConfirmation = true
                }
            }
        }
        .navigationTitle("Modifica Task")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Annulla") {
                    dismiss() // annulla e chiude
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Salva") {
                    onSave(editedTask)
                    dismiss()
                }
            }
        }
        .alert("Confermi di voler eliminare questo task?", isPresented: $showDeleteConfirmation) {
            Button("Elimina", role: .destructive) {
                onDelete(originalTask)
                dismiss()
            }
            Button("Annulla", role: .cancel) {}
        }
    }
}


#Preview {
    NavigationStack {
        TaskDetailView(
            task: TaskItem(emoji: "📚", title: "Studiare", description: "Capitolo 4", dueDate: Date()),
            onSave: { _ in },
            onDelete: { _ in }
        )
    }
}
