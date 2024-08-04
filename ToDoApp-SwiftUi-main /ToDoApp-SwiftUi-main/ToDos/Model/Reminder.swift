import Foundation
import SwiftData

@Model
final class Reminder {
    var name: String
    var isCompleted = false
    var isUrgent = false

    init(name: String, isCompleted: Bool = false, isUrgent: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
        self.isUrgent = isUrgent
    }
}
