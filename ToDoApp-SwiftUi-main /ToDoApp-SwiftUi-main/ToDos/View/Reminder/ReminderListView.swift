//Created By S2G8 

import SwiftUI
import SwiftData

struct ReminderListView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var reminderList: ReminderList
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SearchBar(text: $searchText)
                .padding(.horizontal)
            
            HStack {
                Text(reminderList.name)
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .bold()
                Spacer()
                Text("\(filteredReminders.count)")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            List {
                ForEach(filteredReminders) { reminders in
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
    }
    
    // Filtering logic
    var filteredReminders: [Reminder] {
        if searchText.isEmpty {
            return reminderList.reminder
        } else {
            return reminderList.reminder.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}