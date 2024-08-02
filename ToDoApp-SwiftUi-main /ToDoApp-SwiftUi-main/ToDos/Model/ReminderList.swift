//Created By S2G8 
import Foundation
import SwiftData

@Model
final class ReminderList {
    var name: String
    var iconName: String
    @Relationship(deleteRule: .cascade) var reminder = [Reminder]()
    
    init(name: String = "", iconName: String = "list.bullet", reminder: [Reminder] = [Reminder]()) {
        self.name = name
        self.iconName = iconName
        self.reminder = reminder
    }
}
