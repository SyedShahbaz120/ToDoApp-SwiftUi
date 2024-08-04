import SwiftUI
import SwiftData

struct ReminderListView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var reminderList: ReminderList
    @State private var newReminderName = ""
    @State private var showEditView = false
    @State private var editedReminder: Reminder?
    @State private var editText = ""
    @State private var isUrgent = false

    var body: some View {
        VStack {
            HStack {
                TextField("New reminder", text: $newReminderName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: addReminder) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                        .padding(8)
                        .background(Circle().fill(Color(UIColor.systemGray5)))
                }
            }
            .padding()

            List {
                ForEach(reminderList.reminder) { reminder in
                    HStack {
                        Button(action: {
                            toggleReminder(reminder)
                        }) {
                            Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(reminder.isCompleted ? .green : .gray)
                        }
                        .buttonStyle(PlainButtonStyle())

                        Text(reminder.name)
                            .strikethrough(reminder.isCompleted, color: .gray)
                            .foregroundColor(reminder.isCompleted ? .gray : .primary)

                        Spacer()

                        if reminder.isUrgent {
                            Text("Urgent")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }

                        Button(action: {
                            editReminder(reminder)
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .onDelete(perform: deleteReminder)
            }
        }
        .navigationTitle(reminderList.name)
        .sheet(isPresented: $showEditView) {
            VStack {
                TextField("Edit reminder", text: $editText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Toggle("Mark as Urgent", isOn: $isUrgent)
                    .padding()
                Button("Save") {
                    saveEdit()
                }
                .padding()
            }
        }
    }

    func addReminder() {
        guard !newReminderName.isEmpty else { return }
        let reminder = Reminder(name: newReminderName)
        reminderList.reminder.append(reminder)
        newReminderName = ""
    }

    func toggleReminder(_ reminder: Reminder) {
        if let index = reminderList.reminder.firstIndex(where: { $0.id == reminder.id }) {
            reminderList.reminder[index].isCompleted.toggle()
        }
    }

    func deleteReminder(at offsets: IndexSet) {
        reminderList.reminder.remove(atOffsets: offsets)
    }

    func editReminder(_ reminder: Reminder) {
        editedReminder = reminder
        editText = reminder.name
        isUrgent = reminder.isUrgent
        showEditView = true
    }

    func saveEdit() {
        if let reminder = editedReminder, let index = reminderList.reminder.firstIndex(where: { $0.id == reminder.id }) {
            reminderList.reminder[index].name = editText
            reminderList.reminder[index].isUrgent = isUrgent
        }
        showEditView = false
    }
}
