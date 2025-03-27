import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var emoji = ""
    @State private var selectedDays: Set<Weekday> = []
    @State private var selectAll = false
    @State private var hasTime = false // 🆕
    @State private var time = Date()   // 🆕

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

                // 🆕 Sezione orario opzionale
                Section(header: Text("Orario (opzionale)")) {
                    Toggle("Imposta orario", isOn: $hasTime)
                    if hasTime {
                        DatePicker("Ora", selection: $time, displayedComponents: .hourAndMinute)
                    }
                }

                Section(header: Text("Ricorrenza settimanale")) {
                    Toggle("Tutti i giorni", isOn: $selectAll)
                        .onChange(of: selectAll) { _, newValue in
                            selectedDays = newValue ? Set(Weekday.allCases) : []
                        }

                    ForEach(Weekday.allCases, id: \.self) { day in
                        Toggle(day.fullName, isOn: bindingForDay(day))
                    }
                }
            }
            .navigationTitle("Nuova Abitudine")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Aggiungi") {
                        let habit = Habit(
                            name: name,
                            emoji: emoji.isEmpty ? "🖊️" : emoji,
                            recurrence: Array(selectedDays),
                            time: hasTime ? time : nil // 🆕
                        )
                        onAdd(habit)
                        dismiss()
                    }
                    .disabled(name.isEmpty || selectedDays.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") { dismiss() }
                }
            }
        }
    }

    // MARK: - Helper per toggle

    private func bindingForDay(_ day: Weekday) -> Binding<Bool> {
        Binding(
            get: { selectedDays.contains(day) },
            set: { isOn in
                if isOn {
                    selectedDays.insert(day)
                    if selectedDays.count == Weekday.allCases.count {
                        selectAll = true
                    }
                } else {
                    selectedDays.remove(day)
                    selectAll = false
                }
            }
        )
    }
}

#Preview {
    AddHabitView { _ in }
}
