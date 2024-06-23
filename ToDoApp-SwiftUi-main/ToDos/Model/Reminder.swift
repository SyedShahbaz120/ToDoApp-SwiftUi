//Created By S2G8 
import Foundation
import SwiftData

@Model
final class Reminder {
    var name: String
    var isCompleted = false
    
    init(name: String, isCompleted: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
    }
}
