//
//  TimerModal.swift
//  395 Final Project
//
//  Created by Justin Vu on 10/26/24.
//

import Foundation

let kDisableTimerWhenAppIsNotActive = false

class TimerModal: ObservableObject {
    @Published var timeRemaining: TimeInterval = 15
    @Published var isFocused: Bool = true
    @Published var isRunning: Bool = false
//    static var showAlert: Bool = false
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}
