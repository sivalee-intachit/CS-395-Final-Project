//
//  TaskRow.swift
//  395 Final Project
//
//  Created by Sivalee Intachit on 10/21/24.
//

import SwiftUI

struct TaskRow: View {
    let task: TaskModal
    var onComplete: (TaskModal) -> Void

    var body: some View {
        HStack {
            Button(action: {
                var updatedTask = task
                updatedTask.isComplete.toggle()
                if updatedTask.isComplete {
                    updatedTask.completedDate = Date()
                } else {
                    updatedTask.completedDate = nil
                }
                onComplete(updatedTask)
            }) {
                Image(systemName: task.isComplete ? "app.fill" : "app")
                    .foregroundColor(Color(hex: "#E0D9D5"))
                    .font(.system(size: 25))
                    .padding(.trailing, 8)
                    
            }
            VStack(alignment: .leading) {
                Text(task.title)
                    .foregroundColor(task.isComplete ? .secondary : Color(hex: "#6D5F60"))
                    .font(.poppinsMedium)
                HStack {
                    Text("\(task.dueDate, format: .dateTime.day().month())")
                        .foregroundColor(Date() > task.dueDate ? Color(hex: "E68580") : Color(hex: "#6D5F60"))
                        .font(.poppinsRegular)
                        .padding(.trailing, 10)
                        .frame(alignment: .trailing)
                    if let note = task.note, !note.isEmpty {
                        Text(note)
                            .font(.poppinsRegular)
                            .foregroundColor(Color(hex: "#948A8B"))
                    }
                }
                
            }
        }
    }
}

#Preview {
    TaskRow(
        task: TaskModal(
            id: UUID().uuidString,
            title: "Finish SwiftUI Project",
            note: "Complete by end of the week",
            dueDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            isComplete: false
        ),
        onComplete: { updatedTask in
            print("Task completed: \(updatedTask.title)")
        }
    )
}
