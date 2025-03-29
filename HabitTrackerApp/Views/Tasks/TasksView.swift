import SwiftUI

struct TasksView: View {
    @StateObject private var viewModel = TasksViewModel()
    @State private var showingAddTask = false
    @State private var editingTask: TaskItem?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Task")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 4)
                    
                    if !viewModel.todayTasks.isEmpty {
                        Text("Oggi")
                            .font(.title3).bold()
                        ForEach(viewModel.todayTasks) { task in
                            TaskCardView(
                                task: task,
                                onToggle: { viewModel.toggleCompletion(task) },
                                onTap: { editingTask = task },
                                isToday: true
                            )
                        }
                    }

                    if !viewModel.upcomingTasks.isEmpty {
                        Text("Prossimi giorni")
                            .font(.title3).bold()
                        ForEach(viewModel.upcomingTasks) { task in
                            TaskCardView(
                                task: task,
                                onToggle: {}, // completamento disattivato
                                onTap: { editingTask = task },
                                isToday: false
                            )
                        }
                    }
                }
                .padding()
            }
        
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                            .padding(6)
                            .padding(.trailing, 6)
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView { newTask in
                    viewModel.addTask(newTask)
                }
            }
            .sheet(item: $editingTask) { task in
                NavigationStack {
                    TaskDetailView(
                        task: task,
                        onSave: { viewModel.updateTask($0) },
                        onDelete: { viewModel.deleteTask($0) }
                    )
                }
            }
        }
    }
}

#Preview {
    TasksView()
}
