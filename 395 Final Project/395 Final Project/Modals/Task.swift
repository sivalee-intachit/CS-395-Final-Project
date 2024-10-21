//
//  Task.swift
//  395 Final Project
//
//  Created by Sivalee Intachit on 10/21/24.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: String
    var title: String
    var note: String?
    var dueDate: Date
    var isComplete: Bool
    var completedDate: Date?
    var createdDate: Date

    init(id: String = UUID().uuidString, title: String, note: String? = nil, dueDate: Date = Date(), isComplete: Bool = false, completedDate: Date? = nil) {
        self.id = id
        self.title = title
        self.note = note
        self.dueDate = dueDate
        self.isComplete = isComplete
        self.completedDate = completedDate
        self.createdDate = Date()
    }
}

extension Task {
    static func save(_ tasks: [Task]) {
        let data = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(data, forKey: "Tasks")
    }

    static func getTasks() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: "Tasks"),
              let tasks = try? JSONDecoder().decode([Task].self, from: data) else {
            return []
        }
        return tasks
    }
}
