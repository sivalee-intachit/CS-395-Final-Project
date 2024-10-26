//
//  TimerModal.swift
//  395 Final Project
//
//  Created by Justin Vu on 10/26/24.
//

import Foundation

struct TimerModal: Identifiable, Codable {
    var id: String
    var timeRemaining: TimeInterval
    var isFocused: Bool
    var isRunning: Bool
    var showAlert: Bool
    
    init() {
        self.id = UUID().uuidString
        self.timeRemaining = 15
        self.isFocused = true
        self.isRunning = false
        self.showAlert = false
    }
}
