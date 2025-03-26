import SwiftUI

struct HabitDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var habit: Habit
    var onSave: (Habit) -> Void

    var body: some View {
        Form {
            Section(header: Text("Emoji")) {
                TextField("Emoji", text: $habit.emoji)
            }
            Section(header: Text("Nome")) {
                TextField("Nome", text: $habit.name)
            }
            Section(header: Text("Ricorrenza")) {
                ForEach(Weekday.allCases) { day in
                    Toggle(day.displayName, isOn: Binding(
                        get: { habit.recurrence.contains(day) },
                        set: { isOn in
                            if isOn {
                                habit.recurrence.append(day)
                            } else {
                                habit.recurrence.removeAll(where: { $0 == day })
                            }
                        }
                    ))
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
    }
}

#Preview {
    HabitDetailView(habit: Habit(name: "Allenamento", emoji: "🏃‍♂️", recurrence: [.monday, .wednesday]), onSave: { _ in })
}
