import SwiftUI

struct HomeView: View {
    @State private var username = "Luca"
    @StateObject private var tasksViewModel = TasksViewModel()
    @StateObject private var habitsViewModel = HabitsViewModel()
    @State private var showingCalendar = false

    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "it_IT")
        formatter.dateFormat = "EEEE d MMMM yyyy"
        return formatter.string(from: Date()).capitalized
    }

    private var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Header benvenuto
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ciao, \(username) 👋")
                            .font(.title)
                            .bold()
                        Text(currentDate)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top)

                    // Task di oggi
                    VStack(alignment: .leading) {
                        Text("Task di oggi")
                            .font(.headline)
                        ForEach(tasksViewModel.tasks.filter { Calendar.current.isDateInToday($0.dueDate) }) { task in
                            HStack {
                                Text(task.emoji).font(.title2)
                                VStack(alignment: .leading) {
                                    Text(task.title).bold()
                                    Text(task.description).font(.caption).foregroundColor(.gray)
                                }
                            }
                        }
                    }

                    // Abitudini di oggi
                    VStack(alignment: .leading) {
                        Text("Abitudini di oggi")
                            .font(.headline)
                        ForEach(habitsViewModel.habits.filter { $0.recurrence.contains(currentWeekday) }) { habit in
                            HStack {
                                Text(habit.emoji).font(.title2)
                                Text(habit.name).bold()
                            }
                        }
                    }

                    // Task e abitudini di domani
                    VStack(alignment: .leading) {
                        Text("Domani")
                            .font(.headline)

                        let tomorrowTasks = tasksViewModel.tasks.filter { Calendar.current.isDate($0.dueDate, inSameDayAs: tomorrow) }
                        let tomorrowHabits = habitsViewModel.habits.filter { $0.recurrence.contains(tomorrowWeekday) }

                        if tomorrowTasks.isEmpty && tomorrowHabits.isEmpty {
                            Text("Nessuna attività prevista")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        } else {
                            ForEach(tomorrowTasks) { task in
                                HStack {
                                    Text(task.emoji).font(.title2)
                                    Text(task.title)
                                }
                            }
                            ForEach(tomorrowHabits) { habit in
                                HStack {
                                    Text(habit.emoji).font(.title2)
                                    Text(habit.name)
                                }
                            }
                        }
                    }

                    // Pulsante calendario
                    Button(action: {
                        showingCalendar = true
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                            Text("Apri calendario settimanale")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
            .sheet(isPresented: $showingCalendar) {
                CalendarView(tasks: tasksViewModel.tasks, habits: habitsViewModel.habits)
            }
            .onAppear {
                tasksViewModel.loadMockTasks()
                habitsViewModel.mockHabits()
            }
        }
    }

    private var currentWeekday: Weekday {
        let weekday = Calendar.current.component(.weekday, from: Date())
        return Weekday(rawValue: weekday == 1 ? 7 : weekday - 1) ?? .monday
    }

    private var tomorrowWeekday: Weekday {
        let weekday = Calendar.current.component(.weekday, from: tomorrow)
        return Weekday(rawValue: weekday == 1 ? 7 : weekday - 1) ?? .monday
    }
}

#Preview("Home Preview") {
    HomeView()
}
