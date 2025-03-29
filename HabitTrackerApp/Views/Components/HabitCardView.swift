import SwiftUI

struct HabitCardView: View {
    let habit: Habit
    let currentWeekday: Weekday
    let currentDate: Date
    let onToggle: () -> Void
    let onTap: () -> Void
    let isToday: Bool

    private var selectedDays: [Weekday] {
        habit.recurrence.sorted { $0.rawValue < $1.rawValue }
    }

    private var completedCount: Int {
        selectedDays.filter { habit.completions[$0] == true }.count
    }

    private var completionRatio: CGFloat {
        guard !selectedDays.isEmpty else { return 0 }
        return CGFloat(completedCount) / CGFloat(selectedDays.count)
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            progressLayer

            VStack(spacing: 0) {
                dayLabelsBar

                contentBody
            }
        }
        .frame(minHeight: 90)
        .background(Color.yellow.opacity(0.3))
        .cornerRadius(12)
        .onTapGesture {
            onTap()
        }
    }

    // MARK: - Riempimento dinamico
    private var progressLayer: some View {
        GeometryReader { geo in
            let width = geo.size.width * completionRatio

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.3))
                    .frame(width: width)

                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.white.opacity(0.05), Color.white.opacity(0.1)]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .frame(width: width)
            }
            .animation(.easeInOut(duration: 0.4), value: completionRatio)
        }
    }

    // MARK: - Giorni in alto
    private var dayLabelsBar: some View {
        HStack(spacing: 0) {
            ForEach(selectedDays, id: \.self) { day in
                Text(day.shortSymbol)
                    .font(.caption2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 22)
                    .foregroundColor(AppColors.habitLabelText)
                    .background(Color.clear)
                    //.overlay(Rectangle().stroke(Color.white.opacity(0.2), lineWidth: 0.5))
                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
            }
        }
        .cornerRadius(12, corners: [.topLeft, .topRight])
    }

    private func labelColor(for day: Weekday) -> Color {
        habit.completions[day] == true
            ? AppColors.habitCompleted
            : AppColors.habitPending
    }

    // MARK: - Contenuto principale
    private var contentBody: some View {
        HStack(spacing: 12) {
            VStack {
                Rectangle()
                    .fill(Color.purple)
                    .frame(width: 4, height: 60)
                    .cornerRadius(2)
            }
            .padding(.leading, 8)

            Text(habit.emoji)
                .font(.system(size: 44))
                .frame(width: 50)

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Text(habit.name)
                        .font(.headline)

                    // 🆕 Mostra orario se esiste
                    if let time = habit.time {
                        Text(time.formatted(date: .omitted, time: .shortened))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Text("\(completedCount)/\(selectedDays.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Button(action: onToggle) {
                Image(systemName: (habit.completions[currentWeekday] ?? false) ? "checkmark.circle.fill" : "checkmark.circle")
                    .font(.title2)
            }
            .disabled(!isToday)
            .opacity(isToday ? 1.0 : 0.4)
        }
        .padding()
    }
}

//randomchange to test commit
