import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var emoji = ""
    @State private var selectedDays: Set<Weekday> = []
    @State private var selectAll = false

    var onAdd: (Habit) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Emoji")) {
                    TextField("Es. 📚", text: $emoji)
                }

                Section(header: Text("Nome Abitudine")) {
                    TextField("Nome", text: $name)
                }

                Section(header: Text("Ricorrenza settimanale")) {
                    Toggle("Tutti i giorni", isOn: $selectAll)
                        .onChange(of: selectAll) { value in
                            selectedDays = value ? Set(Weekday.allCases) : []
                        }

                    ForEach(Weekday.allCases) { day in
                        Toggle(day.displayName, isOn: Binding(
                            get: { selectedDays.contains(day) },
                            set: { isOn in
                                if isOn {
                                    selectedDays.insert(day)
                                } else {
                                    selectedDays.remove(day)
                                    selectAll = false
                                }
                            }
                        ))
                    }
                }
            }
            .navigationTitle("Nuova Abitudine")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Aggiungi") {
                        let habit = Habit(name: name, emoji: emoji.isEmpty ? "🖊️" : emoji, recurrence: Array(selectedDays))
                        onAdd(habit)
                        dismiss()
                    }.disabled(name.isEmpty || selectedDays.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    AddHabitView { _ in }
}
