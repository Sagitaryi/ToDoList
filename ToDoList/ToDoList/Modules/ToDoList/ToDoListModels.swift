//
//  ToDoListEntities.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 05.12.2024.
//

import Foundation

struct ToDoList: Hashable {
    let toDoList: [ToDoItem]
}

struct ToDoItem: Hashable {
    let id: UUID
    let title: String
    let description: String
    let createdAt: Date
    let isCompleted: Bool
}

extension ToDoList {
    init?(response: ToDoDTO) {
        let toDoItems = response.todos.compactMap { todoDTO -> ToDoItem in
            let id = UUID()
            let title = todoDTO.todo
            let description = todoDTO.todo
            let createdAt = Date()
            let isCompleted = todoDTO.completed ?? false

            return ToDoItem(id: id, title: title, description: description, createdAt: createdAt, isCompleted: isCompleted)
        }
        self.init(toDoList: toDoItems)
    }
}
