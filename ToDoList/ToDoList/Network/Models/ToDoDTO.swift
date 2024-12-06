//
//  Untitled.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 05.12.2024.
//

import Foundation

struct ToDoDTO: Decodable {
    let todos: [ToDoListDTO]
    let total: Int?
    let skip: Int?
    let limit: Int?
}

struct ToDoListDTO: Decodable {
    let id: Int?
    let todo: String
    let completed: Bool?
    let userID: Int?
}

