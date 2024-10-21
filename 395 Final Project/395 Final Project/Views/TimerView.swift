//
//  TimerView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI

struct TimerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            Spacer()
            
            ZStack {
                Color(hex: "#FDF8F3")
                    .ignoresSafeArea()
                
                VStack {
                    //                Spacer()
                    
                    // a count of the tasks remaining
                    Text("tasks remaining")
                        .padding()
                    
                    //Spacer()
                    
                    //the timer count down and circle countdown
                    //FIXME: currently temp icons
                    ZStack {
                        Text("timer")
                        Image(systemName: "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                    .padding(25)
                    
                    //                Spacer()
                    
                    //buttons to switch between 25 and 5 minute timers
                    HStack {
                        Spacer()
                        Text("focus")
                        Spacer()
                        Text("break")
                        Spacer()
                    }
                    
                    // buttons to pause/resume and reset timer
                    HStack (spacing: 60) {
                        Image(systemName: "play.fill")
                            .frame(width: 60, height: 60)
                            .background(Color(hex: "B3B792"))
                            .cornerRadius(100)
                        
                        Image(systemName: "pause.fill")
                            .frame(width: 60, height: 60)
                            .background(Color(hex: "E8B6B4"))
                            .cornerRadius(100)
                    }
                    .frame(width:200, height: 90)
                    
                    Spacer()
                }
            }
            .frame(maxHeight: 650)
            //.cornerRadius(10)
        }
    }
}

#Preview {
    TimerView()
}

//extension Color {
//    init(hex: String) {
//        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
//        print(cleanHexCode)
//        var rgb: UInt64 = 0
//
//        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
//
//        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
//        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
//        let blueValue = Double(rgb & 0xFF) / 255.0
//        self.init(red: redValue, green: greenValue, blue: blueValue)
//    }
//}
