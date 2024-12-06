//
//  Entities.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 05.12.2024.
//

import Foundation

struct ToDoList {
    let toDoList: [ToDoItem]
}

struct ToDoItem {
    let id: Int?
    let title: String
    let description: String
    let createdAt: String
    var isCompleted: Bool

}
extension ToDoList {
    init?(response: ToDoDTO) {
        let toDoItems = response.todos.compactMap { todoDTO -> ToDoItem in
            let id = todoDTO.id
            let title = todoDTO.todo
            let description = todoDTO.todo
            let createdAt = "Data()"
            let isCompleted = todoDTO.completed ?? false

            return ToDoItem(id: id, title: title, description: description, createdAt: createdAt, isCompleted: isCompleted)
        }
        self.init(toDoList: toDoItems)
    }
}
