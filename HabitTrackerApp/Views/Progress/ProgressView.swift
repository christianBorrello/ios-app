import SwiftUI
import Charts

struct ProgressView: View {
    @StateObject private var tasksViewModel = TasksViewModel()
    @StateObject private var habitsViewModel = HabitsViewModel()
    
    private var stats: ProgressStats {
        ProgressStats(from: tasksViewModel.tasks, habits: habitsViewModel.habits)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Titolo motivazionale
                    VStack(alignment: .leading, spacing: 4) {
                        Text("🎯 Continua così!")
                            .font(.title2)
                        Text("Hai completato almeno un'attività per \(stats.currentStreak) giorni consecutivi.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    // Grafico settimanale
                    VStack(alignment: .leading) {
                        Text("Attività completate questa settimana")
                            .font(.headline)
                        Chart(stats.weeklyData) {
                            BarMark(
                                x: .value("Giorno", $0.label),
                                y: .value("Completate", $0.count)
                            )
                        }
                        .frame(height: 200)
                    }

                    // Confronto settimanale
                    VStack(alignment: .leading) {
                        Text("Confronto con la settimana precedente")
                            .font(.headline)

                        let diff = stats.weeklyDifference
                        let message = diff > 0
                            ? "📈 +\(diff)% rispetto alla scorsa settimana!"
                            : "📉 \(abs(diff))% in meno rispetto alla scorsa settimana"

                        Text(message)
                            .foregroundColor(diff >= 0 ? .green : .red)
                    }

                    // Totale completamenti
                    VStack(alignment: .leading) {
                        Text("Totale attività completate")
                            .font(.headline)
                        Text("✅ \(stats.totalTasksCompleted) task")
                        Text("🏁 \(stats.totalHabitsCompleted) abitudini")
                    }
                }
                .padding()
            }
            .navigationTitle("Progressi")
        }
        .onAppear {
            tasksViewModel.loadMockTasks()
            habitsViewModel.mockHabits()
        }
    }
}
