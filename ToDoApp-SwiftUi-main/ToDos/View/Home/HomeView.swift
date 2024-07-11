//Created By S2G8 

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var reminderList: [ReminderList]
    @State private var path = [ReminderList]()
    @State private var searchText = ""
    
    // This will allow user to create and view a new entry of useful data
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                // Add Search Bar
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                List {
                    Section {
                        VStack {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(filteredReminders.prefix(4)) { reminders in
                                    ListCardView(reminderList: reminders)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                    .listRowInsets(EdgeInsets())
                    
                    Section {
                        ForEach(filteredReminders) { reminders in
                            NavigationLink {
                                ReminderListView(reminderList: reminders)
                            } label: {
                                ReminderListRowView(reminderList: reminders)
                            }
                            .listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 15))
                        }
                        .onDelete(perform: delete)
                    } header: {
                        Text("My Lists")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Reminders")
            .navigationDestination(for: ReminderList.self, destination: CreateSectionView.init)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addSection) {
                        Label("Add Section", systemImage: "plus")
                    }
                }
            }
            .overlay {
                Group {
                    if reminderList.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No Reminders", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Start adding reminders to see your list.")
                        }, actions: {
                            Button("Add Reminder", action: addSection)
                        })
                        .offset(y: -60)
                    }
                }
            }
        }
    }
    
    // This allows the user to add and delete tasks
    func addSection() {
        let section = ReminderList()
        modelContext.insert(section)
        path = [section]
    }
    
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let reminderLists = reminderList[index]
            modelContext.delete(reminderLists)
        }
    }
    
    // Filtering logic
    var filteredReminders: [ReminderList] {
        if searchText.isEmpty {
            return reminderList
        } else {
            return reminderList.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.reminder.contains { $0.name.localizedCaseInsensitiveContains(searchText) } }
        }
    }
}
