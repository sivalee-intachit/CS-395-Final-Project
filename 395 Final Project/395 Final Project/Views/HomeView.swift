//
//  HomeView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var showingTimerView = false
    @State var showingToDoListView = false
    
    var body: some View {
        ZStack {
            Color(hex: "#B3B792")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack {
                        Text("Today")
                        Text("Date")
                    }
                    Spacer()
                    Text("Icon")
                }
                .padding()
                Spacer()
            }
            
            if (showingTimerView) {
                TimerView()
            }
            if (showingToDoListView) {
                ToDoListView()
            }
            
            VStack {
                Spacer()
                HStack (spacing: 100){
                    Button (action: {
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
    }
}

#Preview {
    HomeView()
}

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
