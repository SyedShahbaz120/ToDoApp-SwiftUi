//Created By S2G8 
import Foundation
import SwiftData

@Model

//this aloows us to create a reminder object
final class Reminder {
    var name: String
    var isCompleted = false

     init(name: String, isCompleted: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
    }
    
   
}
