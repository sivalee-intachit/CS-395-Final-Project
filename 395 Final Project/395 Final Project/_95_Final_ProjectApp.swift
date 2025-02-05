//
//  _95_Final_ProjectApp.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/16/24.
//

import SwiftUI

@main
struct _95_Final_ProjectApp: App {
    var globalTimer = TimerModal()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(TimerModal())
        }
    }
}
