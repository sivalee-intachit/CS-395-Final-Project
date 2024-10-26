//
//  TaskComposeView.swift
//  395 Final Project
//
//  Created by Sivalee Intachit on 10/21/24.
//

import SwiftUI

struct TaskComposeView: View {
    @Environment(\.presentationMode) var presentationMode
    let taskToEdit: Task?
    var onSave: (Task) -> Void
    
    @State private var title = ""
    @State private var note = ""
    @State private var dueDate = Date();
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                NavigationView {
                    Form {
                        TextField("Title", text: $title)
                        TextField("Note", text: $note)
                        DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    }
                    .navigationTitle(taskToEdit == nil ? "New Task" : "Edit Task")
                    .navigationBarItems(leading: Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }, trailing: Button("Done") {
                        if (!title.isEmpty) {
                            let new_task = Task(id: taskToEdit?.id ?? UUID().uuidString, title: title, note: note, dueDate: dueDate, isComplete: taskToEdit?.isComplete ?? false, completedDate: taskToEdit?.completedDate ?? nil)
                            onSave(new_task)
                        }
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                .onAppear {
                    if let task = taskToEdit {
                        title = task.title
                        note = task.note ?? ""
                        dueDate = task.dueDate
                    }
                }
            }
            
        }
    }
}

#Preview {
    TaskComposeView(
        taskToEdit: nil,
        onSave: { task in
            print("Task saved: \(task.title)")
        }
    )
}
