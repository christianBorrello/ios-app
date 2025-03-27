import SwiftUI

struct HomeView: View {
    @StateObject private var tasksViewModel = TasksViewModel()
    @StateObject private var habitsViewModel = HabitsViewModel()
    @State private var editingTask: TaskItem?
    @State private var editingHabit: Habit?
    @State private var showingCalendar = false
    private let habitPreviewLimit = 3

    private var today: Date { Date() }

    private var currentWeekday: Weekday {
        let weekday = Calendar.current.component(.weekday, from: today)
        return Weekday(rawValue: weekday == 1 ? 7 : weekday - 1) ?? .monday
    }

    private var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()
    }

    private var tomorrowWeekday: Weekday {
        let weekday = Calendar.current.component(.weekday, from: tomorrow)
        return Weekday(rawValue: weekday == 1 ? 7 : weekday - 1) ?? .monday
    }

    private var formattedToday: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "it_IT")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: today).capitalized
    }

    private var formattedTomorrow: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "it_IT")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: tomorrow).capitalized
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {

                    // Sezione Oggi (solo Task)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Tasks - \(formattedToday)")
                            .font(.title3)
                            .bold()

                        let todayTasks = tasksViewModel.tasks.filter {
                            Calendar.current.isDateInToday($0.dueDate)
                        }

                        ForEach(todayTasks) { task in
                            TaskCardView(
                                task: task,
                                onToggle: { tasksViewModel.toggleCompletion(task) },
                                onTap: { editingTask = task },
                                isToday: true
                            )
                        }
                    }

                    // Sezione: Tutte le abitudini attive (con anteprima)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Tutte le abitudini attive")
                            .font(.title3)
                            .bold()

                        ForEach(habitsViewModel.habits.prefix(habitPreviewLimit)) { habit in
                            HabitCardView(
                                habit: habit,
                                currentWeekday: currentWeekday,
                                currentDate: today,
                                onToggle: {}, // disattivo toggle
                                onTap: { editingHabit = habit },
                                isToday: false
                            )
                        }

                        if habitsViewModel.habits.count > habitPreviewLimit {
                            Button(action: {
                                showingCalendar = true
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Vedi tutte le abitudini")
                                        .font(.caption)
                                        .padding(8)
                                    Spacer()
                                }
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingCalendar = true
                    }) {
                        Image(systemName: "calendar")
                            .resizable()                   // permette il ridimensionamento
                            .frame(width: 24, height: 24)  // imposta dimensione icona
                            .foregroundColor(.primary)     // colore (opzionale)
                            .padding(6)
                    }
                }
            }
            .sheet(isPresented: $showingCalendar) {
                CalendarView(tasks: tasksViewModel.tasks, habits: habitsViewModel.habits)
            }
            .sheet(item: $editingTask) { task in
                TaskDetailView(
                    task: task,
                    onSave: { tasksViewModel.updateTask($0) },
                    onDelete: { tasksViewModel.deleteTask($0) }
                )
            }
            .sheet(item: $editingHabit) { habit in
                HabitDetailView(
                    habit: habit,
                    onSave: { habitsViewModel.updateHabit($0) },
                    onDelete: { habitsViewModel.deleteHabit($0) }
                )
            }
            .onAppear {
                tasksViewModel.loadMockTasks()
                habitsViewModel.mockHabits()
            }
        }
    }
}


#Preview("Home Preview") {
    HomeView()
}
