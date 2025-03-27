import Foundation
import SwiftUI

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = []

    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }

    func updateHabit(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index] = habit
        }
    }

    func deleteHabit(_ habit: Habit) {
        habits.removeAll { $0.id == habit.id }
    }

    func toggleCompletion(_ habit: Habit, for day: Weekday) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }

        if habits[index].recurrence.contains(day) {
            let current = habits[index].completions[day] ?? false
            habits[index].completions[day] = !current

            // Streak aggiornato solo per oggi
            if Calendar.current.isDateInToday(Date()) {
                habits[index].streak += habits[index].completions[day]! ? 1 : -1
                habits[index].streak = max(0, habits[index].streak)
            }
        }
    }

    func mockHabits() {
        let example1 = Habit(
            name: "Allenamento",
            emoji: "🏃‍♂️",
            recurrence: [.monday, .wednesday, .friday],
            completions: [.monday: true, .wednesday: false, .friday: false],
            streak: 1
        )
        let example2 = Habit(
            name: "Leggere",
            emoji: "📚",
            recurrence: Weekday.allCases,
            completions: [.monday: true, .tuesday: true, .wednesday: true, .thursday: true, .friday: false, .saturday: false, .sunday: false],
            streak: 5
        )
        habits = [example1, example2]
    }
}
