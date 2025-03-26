import SwiftUI

struct CalendarView: View {
    let tasks: [TaskItem]
    let habits: [Habit]
    @State private var selectedWeekOffset = 0

    private var weekDates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: today)!.start
        return (0..<7).compactMap { day in
            calendar.date(byAdding: .day, value: day + selectedWeekOffset * 7, to: startOfWeek)
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(weekDates, id: \.self) { date in
                    Section(header: Text(dateFormatted(date))) {
                        let dayTasks = tasks.filter { Calendar.current.isDate($0.dueDate, inSameDayAs: date) }
                        let weekday = Weekday(rawValue: Calendar.current.component(.weekday, from: date) == 1 ? 7 : Calendar.current.component(.weekday, from: date) - 1) ?? .monday
                        let dayHabits = habits.filter { $0.recurrence.contains(weekday) }

                        if dayTasks.isEmpty && dayHabits.isEmpty {
                            Text("Nessuna attività")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(dayTasks) { task in
                                HStack {
                                    Text(task.emoji).font(.title2)
                                    Text(task.title)
                                }
                            }
                            ForEach(dayHabits) { habit in
                                HStack {
                                    Text(habit.emoji).font(.title2)
                                    Text(habit.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Calendario settimanale")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: { selectedWeekOffset -= 1 }) {
                        Image(systemName: "chevron.left")
                        Text("")
                    }
                    Spacer()
                    Button(action: { selectedWeekOffset = 0 }) {
                        Text("Oggi")
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

    private func dateFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "it_IT")
        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: date).capitalized
    }
}

#Preview("Calendar Preview") {
    CalendarView(
        tasks: [
            TaskItem(emoji: "📚", title: "Studiare Swift", description: "", dueDate: Date())
        ],
        habits: [
            Habit(name: "Allenamento", emoji: "🏋️‍♂️", recurrence: [.monday, .wednesday, .friday], completions: [.monday: true, .wednesday: false], streak: 1)
        ]
    )
}

