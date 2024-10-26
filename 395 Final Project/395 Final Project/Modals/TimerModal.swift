//
//  TimerModal.swift
//  395 Final Project
//
//  Created by Justin Vu on 10/26/24.
//

import Foundation

let kDisableTimerWhenAppIsNotActive = false

class TimerModal: ObservableObject {
    private var timer: Timer? = nil
    
    private var previousTimeRemaining: TimeInterval = 0
    private var startDate: Date? = nil
    private var lastStopDate: Date? = nil
    
    @Published var totalTimeRemaining: TimeInterval = 15
    
    private func shutdownTimer() {
        let accumulatedRunningTime = Date().timeIntervalSince(startDate!)
        
        previousTimeRemaining -= accumulatedRunningTime
        totalTimeRemaining = previousTimeRemaining
        
        lastStopDate = Date()
        timer!.invalidate()
        timer = nil
    }
    
    func startTimer() {
        startDate = Date()
        
        if !kDisableTimerWhenAppIsNotActive {
            startDate = lastStopDate
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(update)), userInfo: nil, repeats: true)
    }
    
    @objc private func update() {
        totalTimeRemaining = previousTimeRemaining - Date().timeIntervalSince(startDate!)
    }
    
    func stopTimer() {
        shutdownTimer()
    }
    
    func resetTimer() {
        previousTimeRemaining = 0
        totalTimeRemaining = 15
    }
}

var globalTimerModal = TimerModal()
