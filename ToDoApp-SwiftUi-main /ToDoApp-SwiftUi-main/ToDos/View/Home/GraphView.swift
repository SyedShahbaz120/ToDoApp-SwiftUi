import SwiftUI

struct GraphView: View {
    var completed: Int
    var incomplete: Int

    var total: Int {
        completed + incomplete
    }

    var completedPercentage: Double {
        guard total > 0 else { return 0 }
        return (Double(completed) / Double(total)) * 100
    }

    var incompletePercentage: Double {
        guard total > 0 else { return 0 }
        return (Double(incomplete) / Double(total)) * 100
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Tasks Overview")
                .font(.headline)

            HStack(spacing: 20) {
                VStack {
                    Text("Completed")
                    Text("\(completed)")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }

                VStack {
                    Text("Incomplete")
                    Text("\(incomplete)")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }

            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: geometry.size.width * CGFloat(completedPercentage / 100), height: 20)

                    Rectangle()
                        .fill(Color.red)
                        .frame(width: geometry.size.width * CGFloat(incompletePercentage / 100), height: 20)
                }
                .cornerRadius(10)
            }
            .frame(height: 20)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
