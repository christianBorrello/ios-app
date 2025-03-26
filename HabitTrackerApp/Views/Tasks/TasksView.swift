import SwiftUI

struct TasksView: View {
    @StateObject private var viewModel = TasksViewModel()
    @State private var showingAddTask = false

    var body: some View {
        NavigationView {
            List {
                if !viewModel.todayTasks.isEmpty {
                    Section(header: Text("Oggi")) {
                        ForEach(viewModel.todayTasks) { task in
                            taskRow(task)
                        }
                    }
                }
                if !viewModel.upcomingTasks.isEmpty {
                    Section(header: Text("Prossimi giorni")) {
                        ForEach(viewModel.upcomingTasks) { task in
                            taskRow(task)
                        }
                    }
                }
            }
            .navigationTitle("Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView { newTask in
                    viewModel.addTask(newTask)
                }
            }
        }
    }

    private func taskRow(_ task: TaskItem) -> some View {
        HStack {
            Text(task.emoji).font(.largeTitle)
            VStack(alignment: .leading) {
                Text(task.title).font(.headline)
                Text(task.dueDate, style: .date)
                    .font(.caption).foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    TasksView()
}
