//
//  CalenderView.swift
//  395 Final Project
//
//  Created by Justin Vu on 10/24/24.
//

import SwiftUI

struct CalenderView: View {
    @State var selectedMonth = 0
    @State private var selectedDate: Date = Date()
    @State private var currentDate = Date()
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            Spacer()
            
            // Month Selector
            HStack {
                // Previous Month
                Button {
                    withAnimation {
                        selectedMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "#FDF8F3"))
                        .font(.system(size: 20))
                }
                .padding(.leading, 25)
                
                Spacer()
                
                // Next Month
                Text(selectedDate.monthAndYear())
                    .font(Font.custom("Poppins-SemiBold", size: 20))
                    .foregroundColor(Color(hex: "#FDF8F3"))
                
                Spacer()
                
                Button {
                    withAnimation {
                        selectedMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(hex: "#FDF8F3"))
                        .font(.system(size: 20))
                }
                .padding(.trailing, 25)
            }
            .padding()

            // Header for each day of the week
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(hex: "#FDF8F3"))
                        .frame(width: 40)
                }
            }
            // Days of the month
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(fetchDates()) { value in
                    if value.day != -1 {
                        Text("\(value.day)")
                            .font(Font.custom("Poppins-Medium", size: 20))
                            .foregroundColor(Color(hex: "#FDF8F3"))
                            .background {
                                ZStack {
                                    if value.date.string() == Date().string() {
                                        Circle()
                                            .frame(width: 38, height: 38)
                                            .foregroundColor(Color(hex: "#D5CFC7"))
                                    }
                                }
                            }
                    }
                    else {
                        Text("")
                    }
                }
            }
            .padding(.bottom, 50)
            .frame(width: 325)
            
            HStack {
                Text("\(Task.getUnfinishedTasks().count) Unfinished Tasks")
                    .font(.poppinsMedium)
            }
            .padding()
            .frame(width: 316, height: 36)
            .font(.system(size:18))
            .foregroundStyle(Color(hex: "6D5F60"))
            .background(Color(hex: "F4DAB9"))
            .clipShape(Capsule())
            .padding(.bottom, 15)
            
            HStack {
                Text("\(Task.getOverdueTasks().count) Overdue Tasks")
                    .font(.poppinsMedium)
            }
            .padding()
            .frame(width: 316, height: 36)
            .font(.system(size:18))
            .foregroundStyle(Color(hex: "FDF8F3"))
            .background(Color(hex: "E68580"))
            .clipShape(Capsule())
            
            
            ZStack {
                Color(hex: "#FDF8F3")
            }
            .frame(height: 185)
            .cornerRadius(50)
            .offset(y: 35)
            .padding(.top, 35)
        }
        .onChange(of: selectedMonth) { _ in
            selectedDate = fetchSelectedMonth()
        }
    }
    
    private func fetchDates() -> [CalendarDate] {
        let currentMonth = fetchSelectedMonth()
        var dates = currentMonth.datesOfMonth().map({ CalendarDate(day: calendar.component(.day, from: $0), date: $0)})
        let firstDayOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        
        return dates
    }
    
    func fetchSelectedMonth() -> Date {
        return calendar.date(byAdding: .month, value: selectedMonth, to: Date())!
    }
}

struct CalendarDate: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
}

extension Date {
    func monthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: self)
    }
    
    func datesOfMonth() -> [Date] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = 1
//        let endDate = calendar.date(byAdding:endDateComponents, to: startDate)!
        
        guard let monthRange = calendar.range(of: .day, in: .month, for: startDate) else { return [] }
        var dates: [Date] = []
//        var currentDate = startDate
        
        for day in monthRange {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startDate) {
                dates.append(date)
            }
        }
        
        return dates
    }
    
    func string() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
}

#Preview {
    CalenderView()
}
