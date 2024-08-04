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
                    if reminderList.reminder.contains(where: { $0.isUrgent }) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(12)
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(10)
                .shadow(radius: 2)
            }
            .buttonStyle(PlainButtonStyle())
            .background(
                NavigationLink(
                    destination: ReminderListView(reminderList: reminderList),
                    isActive: $isActive,
                    label: { EmptyView() }
                )
                .hidden()
            )
        }
    }

    var listIcon: some View {
        Image(systemName: reminderList.iconName)
            .font(.system(size: 24))
            .foregroundColor(.white)
    }
}
