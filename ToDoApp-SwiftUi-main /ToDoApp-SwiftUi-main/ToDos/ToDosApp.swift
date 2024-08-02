//Created By S2G8 
import SwiftUI
import SwiftData

@main
struct ToDosApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: ReminderList.self)
    }
}
