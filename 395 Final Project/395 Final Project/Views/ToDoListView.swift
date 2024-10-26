//
//  ToDoListView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI

import SwiftUI

struct ToDoListView: View {
    @Environment(\.dismiss) var dismiss
    // Step 1: Create private mutable variables for tasks, showingComposeView, taskToEdit
    @State private var showingComposeView: Bool = false
    @State private var taskToEdit : Task?
    @State private var tasks : [Task] = []
    // Hint: We will use these in our UI
    // tasks (array)
    // showingComposeView (should start as false, will be used to toggle our TaskComposeView)
    // taskToEdit (This may not exist)
    var body: some View {
        // Step 2: We will be navigating between this view and others, what struct should we surround everything in?
        NavigationView {
            // Step 3: Create a List to display tasks
            List {
                // Step 4: Inside our List we want to iterate over each task
                // a) Each task should be displayed using TaskRow
                // b) onComplete is a closure, call updateTask with the task passed into this closure
                // c) Set the shape to a rectangle -> .contentShape(Rectangle())
                // Add a tap gesture to set taskToEdit and show the compose view
                ForEach(tasks) { task in
                    TaskRow(task: task, onComplete: { updatedTask in
                        updateTask(updatedTask)
                    })
                    .contentShape(Rectangle())
                    .onTapGesture {
                        taskToEdit = task
                        showingComposeView.toggle()
                    }
                }
                // Step 5: Add the onDelete modifier to delete tasks (this should be attached to the struct we use to iterate (NOT LIST)
                // Hint: use the "perform" property of the onDelete modifier
                .onDelete(perform: deleteTasks)
            }
            //Step 6: style the list we display our tasks with using a modifier
            // Hint: .listStyle(PlainListStyle())
            .listStyle(PlainListStyle())
            
            // Step 6: Set the navigation title to "Tasks"
            .navigationTitle("Tasks")
            
            // Step 7: Add a navigation bar item (trailing) to create a new task (button with image inside)
            // a) When pressing the button we want to open our TaskComposeView and ensure the view will display as if we are making a "New Task". What value should we set taskToEdit to ensure TaskComposeView will display "New Task"?
            .navigationBarItems(trailing:
                Button(action: {
                taskToEdit = nil
                showingComposeView.toggle()
            }) {
                Image(systemName: "plus")
            }
            )
            
            // Step 8: Add a sheet to present the TaskComposeView. When we dismiss this sheet it should set our taskToEdit to nil.
            // Hint: sheet will take two parameters/properties, the second one is an onDismiss closure.
            // Ex:  .sheet(p1: v1, onDismiss: {
            //          do stuff when on dismiss
            //      })
            // a) the onSave is a closure, call updateTask with the task passed into this closure
            // b) set taskToEdit to nil
            .sheet(isPresented: $showingComposeView, onDismiss: {
                taskToEdit = nil
            }) {
                TaskComposeView(taskToEdit: taskToEdit, onSave: {updatedTask in
                    updateTask(updatedTask)
                    taskToEdit = nil
                })
            }
        }
        // Step 9: Add the onAppear modifier to our entire UI. When the view appears it should perform refreshTasks
        .onAppear(perform: refreshTasks)
    }


    private func refreshTasks() {
        tasks = Task.getTasks().sorted { lhs, rhs in
            if lhs.isComplete && rhs.isComplete {
                return lhs.completedDate! < rhs.completedDate!
            } else if !lhs.isComplete && !rhs.isComplete {
                return lhs.createdDate < rhs.createdDate
            } else {
                return !lhs.isComplete && rhs.isComplete
            }
        }
    }

    private func updateTask(_ updatedTask: Task) {
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            tasks[index] = updatedTask
        } else {
            tasks.append(updatedTask)
        }
        Task.save(tasks)
        refreshTasks()
    }

    private func deleteTasks(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        Task.save(tasks)
    }
}

#Preview {
    ToDoListView()
}
