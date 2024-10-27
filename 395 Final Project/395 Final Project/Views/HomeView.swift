//
//  HomeView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI
import UserNotifications
import PhotosUI

struct HomeView: View {
    // variable TimerView to show timer
    var timerView = TimerView()
    @EnvironmentObject var globalTimer: TimerModal
    @State private var showAlert: Bool = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // variable ToDoListView to show list
    var toDoListView = ToDoListView()
    // booleans to show certain view
    @State var showingCalView = true
    @State var showingTimerView = false
    @State var showingToDoListView = false
    
    @StateObject var profileView = ProfileViewModal()
    
    var body: some View {
        //want everything to be layered on top of each other
        ZStack {
            Color(hex: "#B3B792")
                .ignoresSafeArea() // avoids borders around edge
            
            // simple Vstack for basic elements on home screen
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Today")
                            .font(.poppinsBlack)
                            .foregroundColor(Color(hex: "#FDF8F3"))
                        Text(Date(), style: .date)
                            .font(.poppinsMedium)
                            .foregroundColor(Color(hex: "#FDF8F3"))
                    }
                    .padding(.leading, 15)
                    
                    Spacer()
                    
                    PhotosPicker(selection: $profileView.selectedItem) {
                        if let profileImage = profileView.profileImage {
                            profileImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65, height: 65)
                                .clipShape(Circle())
                                .padding(.trailing, 8)
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .font(.system(size: 60))
                                .padding(.trailing, 8)
                                .foregroundColor(Color(hex: "#FFF9F4"))
                        }
                    }
                }
                .padding()
                Spacer()
            }
            
            CalenderView()
            
            //if boolean to show views
            if (showingTimerView) {
                timerView
                    .transition(.move(edge: .bottom))
            }
            if (showingToDoListView) {
//                toDoListView
//                    .transition(.move(edge: .bottom))
                toDoListView
                    .opacity(showingToDoListView ? 1 : 0)
                    .offset(y: showingToDoListView ? 0 : UIScreen.main.bounds.height)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showingToDoListView)
            }
            
            // Navigation buttons
            VStack {
                Spacer()
                HStack (spacing: 55){
                    // Timer View
                    Button (action: {
                        withAnimation(.spring) {
                            self.showingCalView = false
                            self.showingTimerView = true
                            self.showingToDoListView = false
                        }
                    }) {
                        Image(systemName: "timer")
                            .foregroundColor(Color(hex: "#372F2F"))
                            .font(.system(size: 20))
                    }
                    .frame(width: 48, height: 48)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(100.0)
                    .tint(.gray)
                    // Calendar/Home View
                    Button (action: {
                        withAnimation(.spring) {
                            self.showingCalView = true
                            self.showingTimerView = false
                            self.showingToDoListView = false
                        }
                    }) {
                        Image(systemName: "calendar")
                            .foregroundColor(Color(hex: "#372F2F"))
                            .font(.system(size: 20))
                    }
                    .frame(width: 48, height: 48)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(100.0)
                    .tint(.gray)
                    // To-Do List View
                    Button (action: {
                        withAnimation(.spring) {
                            self.showingCalView = false
                            self.showingTimerView = false
                            self.showingToDoListView = true
                        }
                    }) {
                        Image(systemName: "list.clipboard")
                            .foregroundColor(Color(hex: "#372F2F"))
                            .font(.system(size: 20))
                    }
                    .frame(width: 48, height: 48)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(100.0)
                    .tint(.gray)
                }
                .frame(width: 322, height: 85, alignment: .center)
                .background(Color(hex: "#D9D9D9").opacity(0.5))
                .cornerRadius(50.0)
                .padding()
            }
        }
        .onReceive(timer) { (_) in
        
            if globalTimer.isRunning {
                
                if globalTimer.timeRemaining <= 0 {
                    globalTimer.stopTimer()
                    showAlert.toggle()
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Pomodoro Timer Finished") , message: Text(globalTimer.isFocused ? "Done focusing, time to take a break!" : "Break time is over, lock back in!"))
        })
    }
}

#Preview {
    HomeView().environmentObject(TimerModal())
}
