import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var emoji = ""
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()

    var onAdd: (TaskItem) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Emoji")) {
                    TextField("Es. 📚", text: $emoji)
                }
                Section(header: Text("Titolo")) {
                    TextField("Inserisci un titolo", text: $title)
                }
                Section(header: Text("Descrizione")) {
                    TextEditor(text: $description).frame(height: 80)
                }
                Section(header: Text("Scadenza")) {
                    DatePicker("Data", selection: $dueDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Nuovo Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Aggiungi") {
                        let task = TaskItem(emoji: emoji.isEmpty ? "📝" : emoji, title: title, description: description, dueDate: dueDate)
                        onAdd(task)
                        dismiss()
                    }.disabled(title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddTaskView { _ in }
}
