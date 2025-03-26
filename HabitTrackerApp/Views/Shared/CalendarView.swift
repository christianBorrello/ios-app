import SwiftUI

struct CalendarView: View {
    let tasks: [TaskItem]
    let habits: [Habit]
    @State private var selectedWeekOffset = 0

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
                    ForEach(weekDates, id: \.self) { date in
                        daySection(for: date)
                    }
                }
                .padding()
            }
            .navigationTitle("Calendario settimanale")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: { selectedWeekOffset -= 1 }) {
                        Image(systemName: "chevron.left")
                        Text("")
                    }
                    Spacer()
                    Button("Oggi") {
                        selectedWeekOffset = 0
                    }
                    Spacer()
                    Button(action: { selectedWeekOffset += 1 }) {
                        Text("")
                        Image(systemName: "chevron.right")
                    }
                }
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
    
    private func daySection(for date: Date) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            let weekday = weekdayForDate(date)
            let isToday = Calendar.current.isDateInToday(date)
            let dayTasks = tasks.filter { Calendar.current.isDate($0.dueDate, inSameDayAs: date) }
            let dayHabits = habits.filter { $0.recurrence.contains(weekday) }

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

            if dayTasks.isEmpty && dayHabits.isEmpty {
                Text("Nessuna attività prevista")
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                ForEach(dayTasks) { task in
                    HStack {
                        Text(task.emoji).font(.title3)
                        VStack(alignment: .leading) {
                            Text(task.title)
                            if !task.description.isEmpty {
                                Text(task.description)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        Button(action: {
                            // TO DO: logica completamento task
                        }) {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                }

                ForEach(dayHabits) { habit in
                    HStack {
                        Text(habit.emoji).font(.title3)
                        Text(habit.name)
                        Spacer()
                        Button(action: {
                            // TO DO: logica completamento abitudine
                        }) {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                }
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
