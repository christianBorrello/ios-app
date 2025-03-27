import Foundation

struct ProgressStats {
    let totalTasksCompleted: Int
    let totalHabitsCompleted: Int
    let currentStreak: Int
    let weeklyData: [DayProgress]
    let weeklyDifference: Int

    init(from tasks: [TaskItem], habits: [Habit]) {
        let calendar = Calendar.current
        let today = Date()

        var weeklyCounts: [Int] = Array(repeating: 0, count: 7)
        var previousWeekCounts: [Int] = Array(repeating: 0, count: 7)

        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -dayOffset, to: today) {
                let weekday = (calendar.component(.weekday, from: date) + 5) % 7 // lun=0, dom=6

                // Task completati
                let taskCount = tasks.filter {
                    $0.isCompleted && calendar.isDate($0.dueDate, inSameDayAs: date)
                }.count

                // Abitudini completate
                let habitCount = habits.filter {
                    let weekdayEnum = Weekday(rawValue: weekday + 1)
                    return weekdayEnum != nil && $0.completions[weekdayEnum!] == true
                }.count

                if dayOffset < 7 {
                    weeklyCounts[6 - dayOffset] = taskCount + habitCount
                } else {
                    previousWeekCounts[6 - (dayOffset - 7)] = taskCount + habitCount
                }
            }
        }

        self.weeklyData = (0..<7).map {
            DayProgress(label: calendar.shortWeekdaySymbols[$0], count: weeklyCounts[$0])
        }

        let totalCurrent = weeklyCounts.reduce(0, +)
        let totalPrevious = previousWeekCounts.reduce(0, +)
        self.weeklyDifference = totalPrevious == 0 ? 100 : Int(Double(totalCurrent - totalPrevious) / Double(totalPrevious) * 100)

        self.totalTasksCompleted = tasks.filter { $0.isCompleted }.count
        self.totalHabitsCompleted = habits.reduce(0) { acc, habit in
            acc + habit.completions.filter { $0.value }.count
        }

        // Streak
        self.currentStreak = weeklyCounts.reversed().prefix(while: { $0 > 0 }).count
    }
}

struct DayProgress: Identifiable {
    let id = UUID()
    let label: String
    let count: Int
}
