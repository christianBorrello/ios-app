import SwiftUI

struct HabitsView: View {
    @StateObject private var viewModel = HabitsViewModel()
    @State private var showingAddHabit = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.habits) { habit in
                    NavigationLink(destination: HabitDetailView(habit: habit, onSave: { updatedHabit in
                        viewModel.updateHabit(updatedHabit)
                    })) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(habit.emoji).font(.largeTitle)
                                VStack(alignment: .leading) {
                                    Text(habit.name).font(.headline)
                                    Text("Streak: \(habit.streak) giorni consecutivi")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack(spacing: 8) {
                                ForEach(habit.recurrence.sorted(), id: \.self) { day in
                                    Circle()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(habit.completions[day] == true ? .green : .gray.opacity(0.3))
                                        .overlay(
                                            Text(day.shortSymbol)
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                        )
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Abitudini")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddHabit = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView { newHabit in
                    viewModel.addHabit(newHabit)
                }
            }
            .onAppear {
                viewModel.mockHabits()
            }
        }
    }
}

#Preview {
    HabitsView()
}
