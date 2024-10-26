//
//  ToDoListView.swift
//  395 Final Project
//
//  Created by Justin Vu on 9/21/24.
//

import SwiftUI

import SwiftUI

struct ToDoListView: View {
    @State private var showingComposeView: Bool = false
    @State private var taskToEdit : Task?
    @State private var tasks : [Task] = []
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
                            ForEach(tasks) { task in
                                TaskRow(task: task, onComplete: { updatedTask in
                                    updateTask(updatedTask)
                                })
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    taskToEdit = task
                                    showingComposeView.toggle()
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 50, bottom: 15, trailing: 50))
                            }
                            .onDelete(perform: deleteTasks)
                        }
                        .listStyle(PlainListStyle())
                        .frame(height: 400)
                        .padding(.bottom, 200)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    taskToEdit = nil
                                    showingComposeView.toggle()
                                    }
                                ) {
                                    Image(systemName: "plus.circle.fill").foregroundColor(Color(hex: "#F4DAB9"))
                                    .font(.system(size: 50))
                                    .padding()
                                }
                                .frame(width: 60, height: 50)
                                .sheet(isPresented: $showingComposeView, onDismiss: {
                                    taskToEdit = nil
                                }) {
                                    TaskComposeView(taskToEdit: taskToEdit, onSave: {updatedTask in
                                        updateTask(updatedTask)
                                        taskToEdit = nil
                                    })
                                }
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
