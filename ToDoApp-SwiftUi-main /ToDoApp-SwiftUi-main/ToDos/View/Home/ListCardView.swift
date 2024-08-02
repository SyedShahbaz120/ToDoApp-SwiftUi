//Created By S2G8 
import SwiftUI
import SwiftData

struct ListCardView: View {
    @Bindable var reminderList: ReminderList
    @State private var isActive = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {
                isActive = true
            } label: {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        listIcon
                            .padding(8)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                        Spacer()
                        Text("\(reminderList.reminder.count)")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    Text(reminderList.name)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(12)
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 1, y: 2)
            }
            .buttonStyle(PlainButtonStyle())
            .background(
                NavigationLink(
                    destination: ReminderListView(reminderList: reminderList),
                    isActive: $isActive,
                    label: { EmptyView() }
                )
                .opacity(0)
                .frame(width: 0, height: 0)
                .disabled(true)
            )
        }
    }
    
    var listIcon: some View {
        Image(systemName: reminderList.iconName)
            .font(.system(size: 24))
            .foregroundColor(.white)
            .padding(8)
    }
}
