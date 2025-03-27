import SwiftUI

struct CalendarView: View {
    let tasks: [TaskItem]
    let habits: [Habit]
    @State private var selectedWeekOffset = 0
    @State private var editingTask: TaskItem?
    @State private var editingHabit: Habit?

    // MARK: - Computed Properties

    private var weekDates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: today)!.start
        return (0..<7).compactMap { day in
            calendar.date(byAdding: .day, value: day + selectedWeekOffset * 7, to: startOfWeek)
        }
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Sezioni dei giorni con task
                    ForEach(weekDates, id: \.self) { date in
                        let dayTasks = tasks.filter {
                            Calendar.current.isDate($0.dueDate, inSameDayAs: date)
                        }

                        Group {
                            if !dayTasks.isEmpty {
                                daySection(for: date, tasks: dayTasks)
                            }
                        }
                    }

                    // Sezione: tutte le abitudini attive
                    Group {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Tutte le abitudini attive")
                                .font(.title3)
                                .bold()

                            ForEach(habits) { habit in
                                HabitCardView(
                                    habit: habit,
                                    currentWeekday: .monday,
                                    currentDate: Date(),
                                    onToggle: {},
                                    onTap: { editingHabit = habit },
                                    isToday: false
                                )
                            }
                        }
                        .padding(.top, 24)
                    }
                }
                .padding()
            }
            .navigationTitle("Calendario settimanale")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: { selectedWeekOffset -= 1 }) {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    Button("Oggi") {
                        selectedWeekOffset = 0
                    }
                    Spacer()
                    Button(action: { selectedWeekOffset += 1 }) {
                        Image(systemName: "chevron.right")
                    }
                }
            }
            // Aggiunta modale task/habit
            .sheet(item: $editingTask) { task in
                TaskDetailView(
                    task: task,
                    onSave: { _ in },
                    onDelete: { _ in }
                )
            }
            .sheet(item: $editingHabit) { habit in
                HabitDetailView(
                    habit: habit,
                    onSave: { _ in },
                    onDelete: { _ in }
                )
            }
        }
    }



    // MARK: - Helpers

    private func formattedDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "it_IT")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }

    private func weekdayForDate(_ date: Date) -> Weekday {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return Weekday(rawValue: weekday == 1 ? 7 : weekday - 1) ?? .monday
    }
    
    private func daySection(for date: Date, tasks: [TaskItem]) -> some View {
        let weekday = weekdayForDate(date)
        let isToday = Calendar.current.isDateInToday(date)

        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(weekday.fullName)
                    .font(.headline)
                Text(formattedDay(date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(6)
            .background(isToday ? Color.blue.opacity(0.1) : Color.clear)
            .cornerRadius(8)

            ForEach(tasks) { task in
                TaskCardView(
                    task: task,
                    onToggle: {
                        // TODO: aggiungi la logica per completamento se vuoi abilitarla qui
                    },
                    onTap: {
                        editingTask = task
                    },
                    isToday: isToday
                )
            }

            Divider()
        }
    }


}


#Preview("Calendar Preview") {
    CalendarView(
        tasks: [
            TaskItem(emoji: "📚", title: "Studiare Swift", description: "Modulo 3", dueDate: Date())
        ],
        habits: [
            Habit(name: "Allenamento", emoji: "🏋️", recurrence: [.monday, .wednesday, .friday], completions: [.monday: true, .wednesday: false], streak: 2)
        ]
    )
}
