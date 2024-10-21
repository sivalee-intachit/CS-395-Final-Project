//
//  HomeView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI

struct HomeView: View {
    // variable TimerView to show timer
    var timerView = TimerView()
    // variable ToDoListView to show list
    var toDoListView = ToDoListView()
    //booleans to show certain view
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
                    VStack {
                        Text("Today")
                        Text(Date(), style: .date)
                    }
                    Spacer()
                    Text("Icon")
                }
                .padding()
                Spacer()
            }
            
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
//                    .sheet(isPresented: $showingTimerView) {
//                        TimerView()
//                    }
                    .tint(.gray)
                    
//                    NavigationLink(destination: TimerView()) {
//                        Image(systemName: "timer")
//                    }
//                    .frame(width: 48, height: 48)
//                    .background(.white)
//                    .cornerRadius(100.0)
                    
                    Button (action: {
                        self.showingTimerView = false
                        self.showingToDoListView.toggle()
                    }) {
                        Image(systemName: "timer")
                    }
                    .frame(width: 48, height: 48)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(100.0)
//                    .sheet(isPresented: $showingToDoListView) {
//                        ToDoListView()
//                    }
                    .tint(.gray)
                }
                .frame(width: 322, height: 85, alignment: .center)
                .background(Color(hex: "#D9D9D9").opacity(0.5))
                .cornerRadius(50.0)
                .padding()
            }
        }
//        .sheet(isPresented: $showingTimerView) {
//            timerView
//        }
    }
}

#Preview {
    HomeView()
}

// Color extension to be able to use hex codes
// does NOT need to be replicated in other files
// to use: Color(hex: #FFFFFF)
extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
