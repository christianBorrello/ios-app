import SwiftUI

struct HabitDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var habit: Habit
    @State private var showDeleteConfirmation = false

    var onSave: (Habit) -> Void
    var onDelete: (Habit) -> Void

    var body: some View {
        Form {
            Section(header: Text("Emoji")) {
                TextField("Emoji", text: $habit.emoji)
            }

            Section(header: Text("Nome")) {
                TextField("Nome", text: $habit.name)
            }

            Section(header: Text("Ricorrenza")) {
                ForEach(Weekday.allCases, id: \.self) { day in
                    Toggle(day.fullName, isOn: Binding(
                        get: {
                            habit.recurrence.contains(day)
                        },
                        set: { isOn in
                            if isOn {
                                if !habit.recurrence.contains(day) {
                                    habit.recurrence.append(day)
                                }
                            } else {
                                habit.recurrence.removeAll(where: { $0 == day })
                            }
                        }
                    ))
                }
            }
            
            Section {
                Button("Elimina abitudine", role: .destructive) {
                    showDeleteConfirmation = true
                }
            }
        }
        .navigationTitle("Modifica Abitudine")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Salva") {
                    onSave(habit)
                    dismiss()
                }
            }
        }
        .alert("Confermi di voler eliminare questa abitudine?", isPresented: $showDeleteConfirmation) {
            Button("Elimina", role: .destructive) {
                onDelete(habit)
                dismiss()
            }
            Button("Annulla", role: .cancel) { }
        }
    }
}

#Preview {
    HabitDetailView(
        habit: Habit(name: "Allenamento", emoji: "🏃‍♂️", recurrence: [.monday, .wednesday]),
        onSave: { _ in },
        onDelete: { _ in }
    )
}
