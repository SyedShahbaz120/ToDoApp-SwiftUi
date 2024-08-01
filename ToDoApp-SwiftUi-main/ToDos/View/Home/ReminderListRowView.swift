import SwiftUI
import SwiftData

struct ReminderListRowView: View {
    @Bindable var reminderList: ReminderList

    var body: some View {
        HStack {
            listIcon
                .frame(width: 36, height: 36)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(Circle())
                .shadow(radius: 3)
            Text(reminderList.name)
            Spacer()
            if reminderList.reminder.contains(where: { $0.isUrgent }) {
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
            }
            Text("\(reminderList.reminder.count)")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }

    var listIcon: some View {
        Image(systemName: reminderList.iconName)
            .font(.system(size: 24))
            .foregroundColor(.white)
            .padding(8)
    }
}
