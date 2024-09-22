//
//  TimerView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
                    .opacity(0.5)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Timer View")
                        .padding()
                        .frame(maxHeight: .infinity)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 10)
                        .background(Color.green.opacity(0.2))
                }
            }
        }
    }
}

#Preview {
    TimerView()
}
