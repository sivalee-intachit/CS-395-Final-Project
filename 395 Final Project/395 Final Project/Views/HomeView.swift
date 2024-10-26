//
//  HomeView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    // variable TimerView to show timer
    var timerView = TimerView()
    // variable ToDoListView to show list
    var toDoListView = ToDoListView()
    // booleans to show certain view
    @State var showingTimerView = false
    @State var showingToDoListView = false
    
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
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 60))
                        .padding(.trailing, 8)
                        .foregroundColor(Color(hex: "#FFF9F4"))
                }
                .padding()
                Spacer()
            }
            
            CalenderView()
            
            //if boolean to show views
            if (showingTimerView) {
                timerView
            }
            if (showingToDoListView) {
                toDoListView
            }
            
            // navigation buttons
            VStack {
                Spacer()
                HStack (spacing: 100){
                    Button (action: {
                        //only showing one view at a time
                        self.showingTimerView.toggle()
                        self.showingToDoListView = false
                    }) {
                        Image(systemName: "timer")
                    }
                    .frame(width: 48, height: 48)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(100.0)
                    .tint(.gray)
                    
                    Button (action: {
                        self.showingTimerView = false
                        self.showingToDoListView.toggle()
                    }) {
                        Image(systemName: "list.clipboard")
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
    }
}

#Preview {
    HomeView().environmentObject(TimerModal())
}
