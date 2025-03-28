import SwiftUI

struct HabitsView: View {
    @StateObject private var viewModel = HabitsViewModel()
    @State private var showingAddHabit = false
    @State private var editingHabit: Habit?

    private var currentWeekday: Weekday {
        let weekday = Calendar.current.component(.weekday, from: Date())
        return Weekday(rawValue: weekday == 1 ? 7 : weekday - 1) ?? .monday
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Abitudini attive")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 4)
                    
                    ForEach(viewModel.habits) { habit in
                        HabitCardView(
                            habit: habit,
                            currentWeekday: currentWeekday,
                            currentDate: Date(),
                            onToggle: {
                                viewModel.toggleCompletion(habit, for: currentWeekday)
                            },
                            onTap: {
                                editingHabit = habit
                            },
                            isToday: true
                        )
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddHabit = true }) {
                        Image(systemName: "plus")
                            .padding(6)
                            .padding(.trailing, 6)
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView { newHabit in
                    viewModel.addHabit(newHabit)
                }
            }
            .sheet(item: $editingHabit) { habit in
                NavigationStack {
                    HabitDetailView(
                        habit: habit,
                        onSave: { viewModel.updateHabit($0) },
                        onDelete: { viewModel.deleteHabit($0) }
                    )
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
