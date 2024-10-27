//
//  ToDoListView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI

struct ToDoListView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var taskToEdit : TaskModal?
    @State private var tasks : [TaskModal] = []
   
    @State private var newTask: Bool = false
    @State private var newTaskTitle : String = ""
    @State private var newTaskNote : String = ""
    @State private var newTaskDueDate : Date = Date()
  
    @EnvironmentObject var globalTimer: TimerModal
    @State private var showAlert: Bool = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Color(hex: "#FDF8F3")
                    .ignoresSafeArea()
                NavigationView {
                    ZStack {
                        Color(hex: "#FDF8F3")
                            .ignoresSafeArea()
                        List {
                            // Input Row for New Task
                            if (newTask) {
                                TaskComposeView(taskToEdit: taskToEdit, onSave: {updatedTask in
                                    updateTask(updatedTask)
                                    taskToEdit = nil
                                    newTask = false
                                })
                                .listRowInsets(EdgeInsets(top: 0, leading: 50, bottom: 10, trailing: 50))
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                            }
                            // Existing task items
                            ForEach(tasks) { task in
                                // If the task has been prompted to be edited, show the task compose view
                                if let taskToEditTemp = taskToEdit, task.id == taskToEditTemp.id {
                                    TaskComposeView(
                                        taskToEdit: taskToEdit,
                                        onSave: { updatedTask in
                                            updateTask(updatedTask)
                                            taskToEdit = nil
                                        }
                                    )
                                    .listRowInsets(EdgeInsets(top: 0, leading: 50, bottom: 10, trailing: 50))
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                }
                                // Otherwise, display the contents of the task normally
                                else {
                                    TaskRow(task: task, onComplete: { updatedTask in
                                        updateTask(updatedTask)
                                    })
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        taskToEdit = task
                                    }
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 50, bottom: 15, trailing: 50))
                                }
                                
                            }
                            .onDelete(perform: deleteTasks)
                        }
                        .listStyle(PlainListStyle())
                        .frame(height: 400)
                        .padding(.bottom, 200)
                        
                        // Add button for adding tasks to the list
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    taskToEdit = nil
                                    newTask.toggle()
                                    }
                                ) {
                                    Image(systemName: "plus.circle.fill")
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(Color(hex: "#6D5F60"), Color(hex: "#F4DAB9"))
                                        .font(.system(size: 50))
                                        .padding()
                                }
                                .frame(width: 60, height: 50)
                            }
                        }
                        .padding(.trailing, 50)
                        .padding(.bottom, 180)
                    }
                    .onAppear(perform: refreshTasks)
                }
            }
            .frame(maxHeight: 750)
            .cornerRadius(50)
        }
        .offset(y: 80)
        .onReceive(timer) { (_) in
            // In-App notification when timer is done
            if globalTimer.isRunning {
                if globalTimer.timeRemaining <= 0 {
                    globalTimer.stopTimer()
                    showAlert.toggle()
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Pomodoro Timer Finished") , message: Text(globalTimer.isFocused ? "Done focusing, time to take a break!" : "Break time is over, lock back in!"))
        })
    }

    private func refreshTasks() {
        tasks = TaskModal.getTasks().sorted { lhs, rhs in
            if lhs.isComplete && rhs.isComplete {
                return lhs.completedDate! < rhs.completedDate!
            } else if !lhs.isComplete && !rhs.isComplete {
                return lhs.createdDate < rhs.createdDate
            } else {
                return !lhs.isComplete && rhs.isComplete
            }
        }
    }

    private func updateTask(_ updatedTask: TaskModal) {
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            tasks[index] = updatedTask
        } else {
            tasks.append(updatedTask)
        }
        TaskModal.save(tasks)
        refreshTasks()
    }

    private func deleteTasks(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        TaskModal.save(tasks)
    }
}

#Preview {
    ToDoListView().environmentObject(TimerModal())
}
