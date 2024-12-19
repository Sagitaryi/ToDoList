//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 07.12.2024.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func getAllItems() -> [ToDoItemEntity]
    func createItem(with model: ToDoItem)
    func updateItem(item: ToDoItem)
    func deleteItem(item: ToDoItemEntity)
    func deleteAllItems()
}

final class CoreDataManager: CoreDataManagerProtocol {
    // MARK: - Private Properties
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    // MARK: - CRUD
    func createItem(with model: ToDoItem) {
        let newItem = ToDoItemEntity(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.date = model.createdAt
        newItem.text = model.description
        newItem.isCompleted = model.isCompleted

        appDelegate.saveContext()
    }

    func getAllItems() -> [ToDoItemEntity] {
        do {
            let items = try context.fetch(ToDoItemEntity.fetchRequest())
            return items
        }
        catch {
            print("Error fetching data: \(error)")
            return []
        }
    }

    func updateItem(item: ToDoItem) {
        let items = getAllItems()

            if let itemToUpdate = items.first(where: { $0.id == item.id }) {
                itemToUpdate.title = item.title
                itemToUpdate.text = item.description
                itemToUpdate.isCompleted = item.isCompleted
            } else {
                print("Data saving error")
            }

        appDelegate.saveContext()
    }

    func deleteItem(item: ToDoItemEntity) {
        context.delete(item)
        appDelegate.saveContext()
    }

    func deleteAllItems() {
        let items = getAllItems()
        items.forEach { item in
            deleteItem(item: item)
        }

    }
}
