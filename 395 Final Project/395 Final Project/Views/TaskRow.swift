//
//  TaskRow.swift
//  395 Final Project
//
//  Created by Sivalee Intachit on 10/21/24.
//

import SwiftUI

struct TaskRow: View {
    let task: Task
    var onComplete: (Task) -> Void

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
                Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isComplete ? .blue : .secondary)
            }
            VStack(alignment: .leading) {
                Text(task.title)
                    .foregroundColor(task.isComplete ? .secondary : .primary)
                if let note = task.note, !note.isEmpty {
                    Text(note)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}


#Preview {
    TaskRow(
        task: Task(
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
