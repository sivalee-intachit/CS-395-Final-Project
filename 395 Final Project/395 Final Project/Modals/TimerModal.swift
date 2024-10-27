//
//  TimerModal.swift
//  395 Final Project
//
//  Created by Justin Vu on 10/26/24.
//

import Foundation

class TimerModal: ObservableObject {
    @Published var timeRemaining: TimeInterval = 8 //1500 //25 mins, 15 for demo
    @Published var isFocused: Bool = true
    @Published var isRunning: Bool = false
    @Published var showAlert: Bool = false
    @Published var timer: Timer?
    
    func startTimer() {
        if !isRunning {
            isRunning = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(update)), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func update() {
        timeRemaining -= 1
    }
    
    func stopTimer() {
        if isRunning {
            isRunning = false
            timer!.invalidate()
            timer = nil
        }
    }
}
