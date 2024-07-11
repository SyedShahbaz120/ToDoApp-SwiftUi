//Created By S2G8 
import SwiftUI
import SwiftData

struct ReminderRowView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var reminder: Reminder
    
    //this is allowed user to add and delete task
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
                .foregroundColor(reminder.isCompleted ? .secondary : .primary)
        }
        .padding(.vertical, 8)
    }
    //this is a test
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

// Previews
import SwiftUI
import SwiftData

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: ReminderList.self, configurations: config)
            let example = ReminderList(name: "App Team", iconName: "iphone", reminder: [
                Reminder(name: "Talk to Shahbaz"),
                Reminder(name: "Collect Points")
            ])
            
            return ReminderListRowView(reminderList: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container")
        }
    }
}
