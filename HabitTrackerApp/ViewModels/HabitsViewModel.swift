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

    func toggleCompletion(for habit: Habit, day: Weekday) {
        guard var existingHabit = habits.first(where: { $0.id == habit.id }) else { return }
        if existingHabit.recurrence.contains(day) {
            existingHabit.completions[day]?.toggle()
            updateHabit(existingHabit)
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
            completions: [.monday: true, .tuesday: true, .wednesday: true, .thursday: true, .friday: true, .saturday: false, .sunday: false],
            streak: 5
        )
        habits = [example1, example2]
    }
}
