//
//  TimerView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI
import UserNotifications

struct TimerView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var globalTimer: TimerModal
    @State private var showAlert: Bool = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
            Spacer()
            
            ZStack {
                Color(hex: "#FDF8F3")
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        // Count of the tasks remaining
                        HStack {
                            Text("\(TaskModal.getUnfinishedTasks().count) Tasks Remaining")
                                .font(.poppinsMedium)
                        }
                        .frame(width: 225, height: 36)
                        .font(.system(size:18))
                        .foregroundStyle(Color(hex: "6D5F60"))
                        .background(Color(hex: "F4DAB9"))
                        .clipShape(Capsule())
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 15, trailing: 0))
                    //Timer interface
                    ZStack {
                        //Circle around the timer
                        Circle()
                            .trim(from: CGFloat(globalTimer.timeRemaining/(globalTimer.isFocused ? 1500 : 300)), to: 1)
                            .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .frame(width: 275, height: 275)
                            .rotationEffect(.init(degrees: -90))
                        //Time in minutes:seconds
                        VStack {
                            Text(formattedTime())
                                .foregroundStyle(Color(hex: "6D5F60"))
                                .font(.system(size:50))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(EdgeInsets(top: 18, leading: 25, bottom: 25, trailing: 25))
                    //Buttons to switch between 25 and 5 minute timers
                    HStack {
                        Spacer()
                        //Focus button, puts 25 min timer
                        Button {
                            globalTimer.stopTimer()
                            globalTimer.timeRemaining = 1500
                            globalTimer.isFocused = true;
                        } label: {
                            HStack {
                                Text("Work")
                                    .font(.poppinsMedium)
                                Image(systemName: "figure.strengthtraining.traditional")
                            }
                            .padding(.vertical)
                            .frame(width: 110, height: 40)
                            .background(Color(hex: "#D9D9D9"))
                            .foregroundStyle(Color(hex: "#FDF8F3"))
                            .font(.system(size:15))
                            .clipShape(Capsule())
                        }
                        Spacer()
                        //Break button, puts 5 min timer
                        Button {
                            globalTimer.stopTimer()
                            globalTimer.timeRemaining = 300
                            globalTimer.isFocused = false;
                        } label: {
                            HStack {
                                Image(systemName: "hand.raised.fill")
                                Text("Break")
                                    .font(.poppinsMedium)
                            }
                            .padding(.vertical)
                            .frame(width: 110, height: 40)
                            .background(Color(hex: "#D9D9D9"))
                            .foregroundStyle(Color(hex: "#FDF8F3"))
                            .font(.system(size:15))
                            .clipShape(Capsule())
                        }
                        Spacer()
                    }
                    // Buttons to pause/resume and reset timer
                    HStack (spacing: 60) {
                        //Play/Pause button
                        Button {
                            globalTimer.isRunning ? globalTimer.stopTimer() : globalTimer.startTimer()
                        } label : {
                            HStack {
                                Image(systemName: globalTimer.isRunning ? "pause.fill" : "play.fill")
                                Text("\(globalTimer.isRunning ? "Pause" : "Play")")
                                    .font(.poppinsMedium)
                            }
                            .padding(.vertical)
                            .frame(width: 130, height: 60)
                            .background(Color(hex: "B3B792"))
                            .foregroundStyle(Color(hex: "#FDF8F3"))
                            .font(.system(size:20))
                            .clipShape(Capsule())
                        }
                        // Reset timer button
                        Button {
                            globalTimer.stopTimer()
                            globalTimer.timeRemaining = (globalTimer.isFocused ? 1500 : 300)
                        } label : {
                            HStack {
                                Text("Restart")
                                    .font(.poppinsMedium)
                                Image(systemName: "arrow.counterclockwise")
                            }
                            .padding(.vertical)
                            .frame(width: 130, height: 60)
                            .background(Color(hex: "E8B6B4"))
                            .foregroundStyle(Color(hex: "#FDF8F3"))
                            .font(.system(size:20))
                            .clipShape(Capsule())
                        }
                    }
                    .frame(width:200, height: 90)
                    Spacer()
                }
            }
            .frame(maxHeight: 750)
            .cornerRadius(50)
        }
        .offset(y: 80)
        .onAppear(perform: {
            // Asks user for permission to send notifications
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (_, _) in
            }
        })
        .onReceive(timer) { (_) in
            // In-App notification when timer is done
            if globalTimer.isRunning {
                if globalTimer.timeRemaining <= 0 {
                    globalTimer.stopTimer()
                    Notify()
                    showAlert.toggle()
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Pomodoro Timer Finished") , message: Text(globalTimer.isFocused ? "Done focusing, time to take a break!" : "Break time is over, lock back in!"))
        })
    }
    
    // Formats time into minutes:seconds
    private func formattedTime() -> String {
        let minutes = Int(globalTimer.timeRemaining) / 60
        let second = Int(globalTimer.timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, second)
    }
    
    //Send notification while app is in background
    public func Notify() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Timer Finished"
        content.body = globalTimer.isFocused ? "Done focusing, time to take a break!" : "Break time is over, lock back in!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
}

#Preview {
    TimerView().environmentObject(TimerModal())
}
