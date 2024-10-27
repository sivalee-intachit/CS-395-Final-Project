//
//  TaskComposeView.swift
//  395 Final Project
//
//  Created by Sivalee Intachit on 10/26/24.
//

import SwiftUI

struct TaskComposeView: View {
    @Environment(\.presentationMode) var presentationMode
    let taskToEdit: TaskModal?
    var onSave: (TaskModal) -> Void
    
    @State private var title = ""
    @State private var note = ""
    @State private var dueDate = Date();
    @State private var showPicker = true
        
    var body: some View {
        
        HStack {
            if (taskToEdit != nil) {
                Image(systemName: taskToEdit?.isComplete == true ? "app.fill" : "app")
                    .foregroundColor(Color(hex: "#E0D9D5"))
                    .font(.system(size: 25))
                    .padding(.trailing, 8)
            }
            else {
                Image(systemName: "app")
                    .foregroundColor(Color(hex: "#E0D9D5"))
                    .font(.system(size: 25))
                    .padding(.trailing, 8)
            }
            VStack(alignment: .leading) {
                TextField("Title", text: $title)
                    .font(.poppinsMedium)
                    .foregroundColor(Color(hex: "#6D5F60"))
                    .padding(.bottom, -5)
                HStack {
                    HStack {
                        Text("\(dueDate, format: .dateTime.day().month())")
                            .font(.poppinsRegular)
                            .padding(.top, -5)
                    }
                    .overlay {
                        DatePicker(selection: $dueDate, displayedComponents: .date) {}
                            .labelsHidden()
                            .contentShape(Rectangle())
                            .colorMultiply(.clear)
                            .accentColor(Color(hex: "#B3B792"))
                    }
                    TextField("Note", text: $note)
                        .font(.poppinsRegular)
                        .foregroundColor(Color(hex: "#6D5F60"))
                        .padding(.top, -5)
                }
            }
            // Save Button
            Button {
                if (!title.isEmpty) {
                    let new_task = TaskModal(id: taskToEdit?.id ?? UUID().uuidString, title: title, note: note, dueDate: dueDate, isComplete: taskToEdit?.isComplete ?? false, completedDate: taskToEdit?.completedDate ?? nil)
                    onSave(new_task)
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Save")
                    .font(.poppinsMedium)
                    .padding(.vertical)
                    .frame(width: 100, height: 40)
                    .background(Color(hex: "#6D5F60"))
                    .foregroundStyle(Color(hex: "#FDF8F3"))
                    .font(.system(size:15))
                    .clipShape(Capsule())
            }
        }
        .onAppear {
            if let taskToEdit {
                title = taskToEdit.title
                note = taskToEdit.note ?? ""
                dueDate = taskToEdit.dueDate
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
