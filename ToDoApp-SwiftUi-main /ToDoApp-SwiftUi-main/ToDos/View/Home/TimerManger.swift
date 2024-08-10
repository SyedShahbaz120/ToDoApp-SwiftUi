//
//  TimerManager.swift
//  ToDos
//
//  Created by RENANYANG on 2024-08-01.
//

import SwiftUI
import Combine

class TimerManager: ObservableObject {
    @Published var remainingTime: Int = 0
    @Published var showAlert: Bool = false
    
    private var timer: Timer?
    
    func startTimer(hours: Int, minutes: Int, seconds: Int) {
        let totalSeconds = hours * 3600 + minutes * 60 + seconds
        remainingTime = totalSeconds
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.timer?.invalidate()
                self.showAlert = true
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        remainingTime = 0
    }
}



