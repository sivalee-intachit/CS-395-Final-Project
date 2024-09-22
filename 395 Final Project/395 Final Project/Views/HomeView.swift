//
//  HomeView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI

struct HomeView: View {
    
//    @State private var selectedTheme = 0
    
    var body: some View {
        ZStack {
            Color(hex: "#B3B792")
                //.opacity(0.5)
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
            VStack {
                Spacer()
                HStack (spacing: 100){
                    NavigationLink(destination: TimerView()) {
                        Image(systemName: "timer")
                    }
                    .frame(width: 48, height: 48)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(100.0)
                    
//                    NavigationLink(destination: TimerView()) {
//                        Image(systemName: "timer")
//                    }
//                    .frame(width: 48, height: 48)
//                    .background(.white)
//                    .cornerRadius(100.0)
                    
                    NavigationLink(destination: ToDoListView()) {
                        Image(systemName: "list.bullet.clipboard")
                    }
                    .frame(width: 48, height: 48)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(100.0)
                }
                .frame(width: 322, height: 85, alignment: .center)
                .background(Color(hex: "#D9D9D9").opacity(0.5))
                .cornerRadius(50.0)
                .padding()
            }
//            (selectedTheme == 0 ? Color.white : Color.black)
//                .edgesIgnoringSafeArea(.all)
            
//            TabView {
//                TimerView()
//                    .tabItem {
//                        Label("Pomodoro", systemImage: "timer")
//                    }
//                    
//                
//                ToDoListView()
//                    .tabItem {
//                        Label("To Do", systemImage: "list.bullet.clipboard")
//                    }
//            }
            
            //.padding()
//            .onAppear() {
//                UITabBar.appearance().backgroundColor = Color(hex: 0xd9d9d9, opacity: 0.5))
//            }
            //.frame(width: 322, alignment: .bottom)
            //.background(.D9D9D980)
        }
        //.background(Color(hex: "#B3B792"), ignoresSafeAreaEdges:.all)
//        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        //.accentColor(selectedTheme == 0 ? .black : .white)
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
