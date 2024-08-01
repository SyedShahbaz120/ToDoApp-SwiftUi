
// Created By S2G8
import Foundation
import SwiftData

@Model
final class Reminder {
    var name: String
    var isCompleted = false
    var isUrgent = false // Add this property

    init(name: String, isCompleted: Bool = false, isUrgent: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
        self.isUrgent = isUrgent
    }
}
