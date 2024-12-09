//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 07.12.2024.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func getAllItems() -> [ToDoListItem]?
    func createItem(with model: ToDoItem)
    func updateItem(item: ToDoItem)
    func deleteItem(item: ToDoListItem)
}

final class CoreDataManager: CoreDataManagerProtocol {
    // MARK: - private let/var
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    // MARK: - CRUD
    func createItem(with model: ToDoItem) {
        let newItem = ToDoListItem(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.date = model.createdAt
        newItem.text = model.description
        newItem.isCompleted = model.isCompleted

        appDelegate.saveContext()
    }

    func getAllItems() -> [ToDoListItem]? {
        do {
            let items = try context.fetch(ToDoListItem.fetchRequest())
            return items
        }
        catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }

    func updateItem(item: ToDoItem) {
        let items = getAllItems()

        if items != nil {
            if let itemToUpdate = items?.first(where: { $0.id == item.id }) {
                itemToUpdate.text = item.description
            } else {
                print("Data saving error")
            }
        }
        appDelegate.saveContext()
    }

    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        appDelegate.saveContext()
    }
}
