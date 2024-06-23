//Created By S2G8 
import SwiftUI
import SwiftData

struct ReminderListView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var reminderList: ReminderList
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(reminderList.name)
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .bold()
                Spacer()
                Text("\(reminderList.reminder.count)")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            List {
                ForEach(reminderList.reminder) { reminders in
                    ReminderRowView(reminder: reminders)
                }
                .onDelete(perform: delete)
            }
            .listStyle(InsetListStyle())
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    reminderList.reminder.append(Reminder(name: ""))
                } label: {
                    HStack(spacing: 7) {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                            .font(.body)
                            .bold()
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical)
        .background(Color(UIColor.systemGroupedBackground))
    }
    
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            reminderList.reminder.remove(at: index)
        }
        try! modelContext.save()
    }}
