//
//  GraphView.swift
//  ToDos
//
//  Created by Syed Shahbaz on 2024-07-04.
//

import Foundation
import SwiftUI

struct GraphView: View {
    var completed: Int
    var incomplete: Int
    
    var body: some View {
        VStack {
            Text("Reminders Completion Status")
                .font(.headline)
                .padding(.bottom, 10)
            
            HStack {
                VStack {
                    Text("Completed")
                        .font(.subheadline)
                    Rectangle()
                        .fill(Color.green.opacity(0.7))
                        .frame(width: 50, height: CGFloat(completed) * 10)
                    Text("\(completed)")
                }
                VStack {
                    Text("Incomplete")
                        .font(.subheadline)
                    Rectangle()
                        .fill(Color.red.opacity(0.7))
                        .frame(width: 50, height: CGFloat(incomplete) * 10)
                    Text("\(incomplete)")
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
