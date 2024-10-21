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
    
    // Step 1: Create private mutable variables for title, note, and dueDate
    @State private var title = ""
    @State private var note = ""
    @State private var dueDate = Date();
    // Hint: We will use these in our UI
    // The title and note should be empty strings, and dueDate should be set to the current date
    // Hint: Date()
    
    var body: some View {
        // Step 2: This view will be navigated to from our TaskListView, what struct should we surround everything in?
        NavigationView {
            // Step 4: Inside the form, add:
            //   a) A TextField for the title
            //   b) A TextField for the note
            //   c) A DatePicker for the due date
            //      Hint: Use DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            Form {
                TextField("Title", text: $title)
                TextField("Note", text: $note)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            // Step 5: Add a navigation title. If you're making a new task (no task to edit) the title should be "New Task" otherwise it should be "Edit Task"
            //   Hint: Use a ternary operator. What constant would help in figuring out if we are editing a task or not?
            .navigationTitle(taskToEdit == nil ? "New Task" : "Edit Task")
            // Step 6: Add navigation bar items
            //   Hint: Use .navigationBarItems(leading: ..., trailing: ...)
            //   Example of displaying text in the leading property:
            //      leading: Text("Displayed Text")
            //   a) For the leading item, add a Cancel button that dismisses the view
            //      Hint: Use presentationMode.wrappedValue.dismiss()
            //   b) For the trailing item, add a Done button that saves the task if the title is not empty and dismisses the view
            //      Hint: If !title.isEmpty, create a new Task and call onSave(new_task)
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
        // Step 7: Add an .onAppear modifier to our entire UI. If the task we are editing exists, then we should set the title, note, and dueDate of this view to the corresponding values of the task.
        .onAppear {
            if let task = taskToEdit {
                title = task.title
                note = task.note ?? ""
                dueDate = task.dueDate
            }
        }
    }
}

//struct TaskComposeView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskComposeView(
//            taskToEdit: nil,
//            onSave: { task in
//                print("Task saved: \(task.title)")
//            }
//        )
//        .previewLayout(.sizeThatFits)
//    }
//}

#Preview {
    TaskComposeView(
        taskToEdit: nil,
        onSave: { task in
            print("Task saved: \(task.title)")
        }
    )
}
