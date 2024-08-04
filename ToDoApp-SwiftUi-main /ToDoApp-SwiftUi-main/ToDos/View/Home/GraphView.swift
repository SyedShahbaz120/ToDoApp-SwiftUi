import SwiftUI

struct GraphView: View {
    var completed: Int
    var incomplete: Int

    var body: some View {
        VStack {
            Text("Tasks Overview")
                .font(.headline)
                .padding(.bottom, 8)
            HStack {
                VStack {
                    Text("Completed")
                    Text("\(completed)")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
                .padding()
                VStack {
                    Text("Incomplete")
                    Text("\(incomplete)")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                .padding()
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
