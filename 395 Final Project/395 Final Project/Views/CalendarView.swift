//
//  CalenderView.swift
//  395 Final Project
//
//  Created by Justin Vu on 10/24/24.
//

import SwiftUI

struct CalenderView: View {
    @State private var selectedDate: Date = Date()
    
    
    var body: some View {
        VStack {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
//                .foregroundColor(Color(hex: "FDF8F3"))
            
            HStack {
                Text("\(TaskModal.getUnfinishedTasks().count) Unfinished Tasks")
                    .font(.poppinsMedium)
            }
            .padding()
            .frame(width: 316, height: 36)
            .font(.system(size:18))
            .foregroundStyle(Color(hex: "6D5F60"))
            .background(Color(hex: "F4DAB9"))
            .clipShape(Capsule())
            
            HStack {
                Text("\(TaskModal.getOverdueTasks().count) Overdue Tasks")
                    .font(.poppinsMedium)
            }
            .padding()
            .frame(width: 316, height: 36)
            .font(.system(size:18))
            .foregroundStyle(Color(hex: "FDF8F3"))
            .background(Color(hex: "E68580"))
            .clipShape(Capsule())
        }
    }
}

#Preview {
    CalenderView()
}
