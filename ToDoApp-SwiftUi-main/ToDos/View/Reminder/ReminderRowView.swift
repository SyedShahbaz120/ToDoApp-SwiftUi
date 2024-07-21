import SwiftUI
import SwiftData

struct ReminderRowView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var reminder: Reminder

    var body: some View {
        HStack {
            Button {
                reminder.isCompleted.toggle()
            } label: {
                if reminder.isCompleted {
                    filledReminderLabel
                } else {
                    emptyReminderLabel
                }
            }
            .frame(width: 20, height: 20)
            .buttonStyle(PlainButtonStyle())
            
            TextField("Enter reminder", text: $reminder.name)
                .foregroundColor(reminder.isCompleted ? .green : .red)  // Color coding
        }
        .padding(.vertical, 8)
    }
    
    var filledReminderLabel: some View {
        Circle()
            .stroke(Color.primary, lineWidth: 2)
            .overlay(
                Circle()
                    .fill(Color.primary)
                    .frame(width: 12, height: 12)
            )
            .frame(width: 20, height: 20)
    }
    
    var emptyReminderLabel: some View {
        Circle()
            .stroke(Color.secondary, lineWidth: 2)
            .frame(width: 20, height: 20)
    }
}
