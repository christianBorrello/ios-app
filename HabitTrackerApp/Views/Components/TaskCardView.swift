import SwiftUI

struct TaskCardView: View {
    let task: TaskItem
    let onToggle: () -> Void
    let onTap: () -> Void
    let isToday: Bool

    var body: some View {
        HStack(spacing: 12) {
            // Etichetta ben distanziata
            Rectangle()
                .fill(Color.blue)
                .frame(width: 6)
                .cornerRadius(3)
                .padding(8)

            // Emoji e contenuto
            HStack(alignment: .center, spacing: 16) {
                Text(task.emoji)
                    .font(.system(size: 44))
                    .frame(width: 50)

                VStack(alignment: .leading, spacing: 12) {
                    Text(task.title)
                        .font(.headline)

                    if !task.description.isEmpty {
                        Text(task.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                Spacer()

                Button(action: onToggle) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                        .font(.title2)
                }
                .disabled(!isToday)
                .opacity(isToday ? 1.0 : 0.4)
            }
            .padding(.trailing, 8)
            .frame(minHeight: 90)
        }
        .background(task.isCompleted ? Color.green.opacity(0.3) : Color.yellow.opacity(0.3))
        .cornerRadius(12)
        .onTapGesture {
            onTap()
        }
    }
}
