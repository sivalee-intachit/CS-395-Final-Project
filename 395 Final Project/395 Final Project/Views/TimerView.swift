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
                    //                Spacer()
                    
                    HStack {
                        // a count of the tasks remaining
                        HStack {
                            Text("\(TaskModal.getUnfinishedTasks().count) Tasks Remaining")
                        }
                        .padding()
                        .frame(width: 200, height: 36)
                        .font(.system(size:18))
                        .foregroundStyle(Color(hex: "6D5F60"))
                        .background(Color(hex: "F4DAB9"))
                        .clipShape(Capsule())
                        
                        Spacer()
                    }
                    .padding(25)
                    
                    //Spacer()
                    
                    //the timer count down and circle countdown
                    ZStack {
                        //timer outline
                        Circle()
                            .trim(from: CGFloat(globalTimer.timeRemaining/(globalTimer.isFocused ? 1500 : 300)), to: 1)
                            .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .frame(width: 300, height: 300)
                            .rotationEffect(.init(degrees: -90))
                        
                        //time in minutes:seconds
                        VStack {
                            Text(formattedTime())
                                .foregroundStyle(Color(hex: "6D5F60"))
                                .font(.system(size:50))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(25)
                    
                    
                    //                Spacer()
                    
                    //buttons to switch between 25 and 5 minute timers
                    HStack {
                        
                        Spacer()
                        
                        //focus button, puts 25 min timer
                        Button {
                            globalTimer.stopTimer()
                            globalTimer.timeRemaining = 1500
                            globalTimer.isFocused = true;
                        } label: {
                            HStack {
                                Text("Work")
                                    .fontWeight(.bold)
                                Image(systemName: "figure.strengthtraining.traditional")
                            }
                            .padding(.vertical)
                            .frame(width: 100, height: 40)
                            .background(Color(hex: "#D9D9D9"))
                            .foregroundStyle(Color(hex: "#FDF8F3"))
                            .font(.system(size:15))
                            .clipShape(Capsule())
                        }
                        
                        Spacer()
                        
                        //break button, puts 5 min timer
                        Button {
                            globalTimer.stopTimer()
                            globalTimer.timeRemaining = 300
                            globalTimer.isFocused = false;
                        } label: {
                            HStack {
                                Image(systemName: "hand.raised.fill")
                                Text("Break")
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical)
                            .frame(width: 100, height: 40)
                            .background(Color(hex: "#D9D9D9"))
                            .foregroundStyle(Color(hex: "#FDF8F3"))
                            .font(.system(size:15))
                            .clipShape(Capsule())
                        }
                        
                        Spacer()
                    }
                    
                    // buttons to pause/resume and reset timer
                    HStack (spacing: 60) {
                        //play/pause button
                        Button {
//                            globalTimer.isRunning.toggle()
                            globalTimer.isRunning ? globalTimer.stopTimer() : globalTimer.startTimer()
                        } label : {
                            HStack {
                                Image(systemName: globalTimer.isRunning ? "pause.fill" : "play.fill")
                                Text("\(globalTimer.isRunning ? "Pause" : "Play")")
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical)
                            .frame(width: 120, height: 60)
                            .background(Color(hex: "B3B792"))
                            .foregroundStyle(Color(hex: "#FDF8F3"))
                            .font(.system(size:20))
                            .clipShape(Capsule())
                        }
                        
//                        Image(systemName: "play.fill")
//                            .frame(width: 60, height: 60)
//                            .background(Color(hex: "B3B792"))
//                            .cornerRadius(100)
                        
                        //reset timer button
                        Button {
                            globalTimer.stopTimer()
                            globalTimer.timeRemaining = (globalTimer.isFocused ? 1500 : 300)
                        } label : {
                            HStack {
                                Text("Restart")
                                    .fontWeight(.bold)
                                Image(systemName: "arrow.counterclockwise")
                            }
                            .padding(.vertical)
                            .frame(width: 120, height: 60)
                            .background(Color(hex: "E8B6B4"))
                            .foregroundStyle(Color(hex: "#FDF8F3"))
                            .font(.system(size:20))
                            .clipShape(Capsule())
                        }
                        
//                        Image(systemName: "pause.fill")
//                            .frame(width: 60, height: 60)
//                            .background(Color(hex: "E8B6B4"))
//                            .cornerRadius(100)
                    }
                    .frame(width:200, height: 90)
                    
                    Spacer()
                }
            }
            .frame(maxHeight: 750)
            .cornerRadius(50)
        }
        .offset(y: 70)
        .onAppear(perform: {
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (_, _) in
                
            }
            
        })
        .onReceive(timer) { (_) in
        
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
    
    private func formattedTime() -> String {
        let minutes = Int(globalTimer.timeRemaining) / 60
        let second = Int(globalTimer.timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, second)
    }
    
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
