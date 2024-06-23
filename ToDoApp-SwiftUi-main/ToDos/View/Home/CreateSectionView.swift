//Created By S2G8 
import SwiftUI
import SwiftData

struct CreateSectionView: View {
    @Bindable var reminderList: ReminderList
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $reminderList.name)
            }
            
            Section(header: Text("Icon")) {
                Picker("Icon", selection: $reminderList.iconName) {
                    ForEach(["house", "heart", "calendar", "flag.fill", "sun.max.fill", "graduationcap", "exclamationmark.3"], id: \.self) { iconName in
                        Image(systemName: iconName)
                            .tag(iconName)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationTitle("Add Section")
        .navigationBarTitleDisplayMode(.inline)
    }
}

