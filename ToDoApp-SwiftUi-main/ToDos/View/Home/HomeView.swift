import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext // Access to the data model context
    @Query var reminderList: [ReminderList] // Query to fetch reminder lists from the data model
    @State private var path = [ReminderList]() // State to manage navigation path
    @State private var searchText = "" // State for the search text
    @State private var showGraph = false  // State variable to control graph visibility

    let columns = [GridItem(.adaptive(minimum: 150))] // Define grid columns for the LazyVGrid

    // Computed property to filter reminder lists based on the search text
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

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                SearchBar(text: $searchText) // Custom search bar view
                    .padding() // Add padding around the search bar

                List {
                    Section {
                        VStack {
                            LazyVGrid(columns: columns, spacing: 10) {
                                // Display a grid of reminder lists, limited to the first 4
                                ForEach(filteredReminderLists.prefix(4)) { reminders in
                                    ListCardView(reminderList: reminders) // Custom view for each reminder list
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.systemGroupedBackground)) // Background color for the list row
                    .listRowInsets(EdgeInsets()) // Remove default insets for the list row

                    Section {
                        // Display each reminder list in a navigation link
                        ForEach(filteredReminderLists) { reminders in
                            NavigationLink {
                                ReminderListView(reminderList: reminders) // Navigate to reminder list view
                            } label: {
                                ReminderListRowView(reminderList: reminders) // Custom view for each reminder list row
                            }
                            .listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 15)) // Custom insets for the list row
                        }
                        .onDelete(perform: delete) // Allow deletion of reminder lists
                    } header: {
                        Text("My Lists")
                            .font(.title3) // Header font size
                            .fontWeight(.bold) // Header font weight
                            .foregroundColor(.primary) // Header font color
                    }
                }
                .listStyle(InsetGroupedListStyle()) // List style with inset and grouped appearance

                // Conditionally display the GraphView if showGraph is true
                if showGraph {
                    GraphView(
                        completed: filteredReminderLists.flatMap { $0.reminder }.filter { $0.isCompleted }.count,
                        incomplete: filteredReminderLists.flatMap { $0.reminder }.filter { !$0.isCompleted }.count
                    )
                    .frame(width: 200, height: 200) // Set the size of the graph
                    .background(Color(UIColor.systemBackground)) // Background color for the graph
                    .cornerRadius(10) // Round corners of the graph view
                    .shadow(radius: 5) // Add shadow to the graph view
                    .padding(.bottom, 20) // Space from the bottom
                    .padding(.trailing, 20) // Space from the right edge
                    .transition(.move(edge: .bottom)) // Animation transition for showing/hiding the graph
                    .animation(.default, value: showGraph) // Animation for graph visibility change
                }
            }
            .navigationTitle("Reminders") // Title for the navigation bar
            .navigationDestination(for: ReminderList.self, destination: CreateSectionView.init) // Define destination for navigation
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addSection) {
                        Label("Add Section", systemImage: "plus") // Button to add a new section
                    }
                }
            }
            .overlay(
                Button(action: {
                    withAnimation {
                        showGraph.toggle() // Toggle the visibility of the graph with animation
                    }
                }) {
                    Text(showGraph ? "Hide Graph" : "Show Graph")
                        .font(.subheadline) // Smaller font size for the button
                        .padding(8) // Reduced padding for the button
                        .background(Color.blue) // Background color for the button
                        .foregroundColor(.white) // Text color for the button
                        .cornerRadius(6) // Round corners of the button
                        .shadow(radius: 3) // Smaller shadow for the button
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.white, lineWidth: 1) // Border for the button
                        )
                }
                .padding()
                .padding(.bottom, 20) // Position button from bottom
                .padding(.trailing, 20) // Position button from right edge
                , alignment: .bottomTrailing
            )
            .overlay {
                Group {
                    // Display a message if there are no reminder lists
                    if filteredReminderLists.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No Reminders", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Start adding reminders to see your list.")
                        }, actions: {
                            Button("Add Reminder", action: addSection) // Button to add a new reminder
                        })
                        .offset(y: -60) // Adjust position from top
                    }
                }
            }
        }
    }

    // Function to add a new section
    func addSection() {
        let section = ReminderList() // Create a new reminder list
        modelContext.insert(section) // Insert the new section into the model context
        path = [section] // Navigate to the newly created section
    }

    // Function to delete selected reminder lists
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let reminderLists = filteredReminderLists[index] // Get the reminder list to delete
            modelContext.delete(reminderLists) // Delete the reminder list from the model context
        }
    }
}
