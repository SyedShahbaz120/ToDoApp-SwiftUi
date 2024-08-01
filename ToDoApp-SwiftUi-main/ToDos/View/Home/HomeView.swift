import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var reminderList: [ReminderList]
    @State private var path = [ReminderList]()
    @State private var searchText = ""
    @State private var showGraph = false

    let columns = [GridItem(.adaptive(minimum: 150))]

    var filteredReminderLists: [ReminderList] {
        if searchText.isEmpty {
            return reminderList
        } else {
            return reminderList.filter { list in
                list.name.localizedCaseInsensitiveContains(searchText) ||
                list.reminder.contains { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
    }

    var totalUrgentTasks: Int {
        reminderList.flatMap { $0.reminder }.filter { $0.isUrgent }.count
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                SearchBar(text: $searchText)
                    .padding()

                Text("Total Urgent Tasks: \(totalUrgentTasks)")
                    .font(.headline)
                    .padding()

                List {
                    Section {
                        VStack {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(filteredReminderLists.prefix(4)) { reminders in
                                    ListCardView(reminderList: reminders)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                    .listRowInsets(EdgeInsets())

                    Section {
                        ForEach(filteredReminderLists) { reminders in
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
                .listStyle(InsetGroupedListStyle())

                if showGraph {
                    GraphView(
                        completed: filteredReminderLists.flatMap { $0.reminder }.filter { $0.isCompleted }.count,
                        incomplete: filteredReminderLists.flatMap { $0.reminder }.filter { !$0.isCompleted }.count
                    )
                    .frame(width: 200, height: 200)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: showGraph)
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
            .overlay(
                Button(action: {
                    withAnimation {
                        showGraph.toggle()
                    }
                }) {
                    Text(showGraph ? "Hide Graph" : "Show Graph")
                        .font(.subheadline)
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                        .shadow(radius: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .padding()
                .padding(.bottom, 20)
                .padding(.trailing, 20)
                , alignment: .bottomTrailing
            )
            .overlay {
                Group {
                    if filteredReminderLists.isEmpty {
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

    func addSection() {
        let section = ReminderList()
        modelContext.insert(section)
        path = [section]
    }

    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let reminderLists = filteredReminderLists[index]
            modelContext.delete(reminderLists)
        }
    }
}
