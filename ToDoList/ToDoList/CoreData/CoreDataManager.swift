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
    func updateToDoCompletionStatus(withId id: UUID)
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

    // MARK: - Creating Data
    func createItem(with model: ToDoItem) {
        let newItem = ToDoItemEntity(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.date = model.createdAt
        newItem.text = model.description
        newItem.isCompleted = model.isCompleted

        appDelegate.saveContext()
    }

    // MARK: - Fetching Data
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

    // MARK: - Updating Data
    func updateItem(item: ToDoItem) {
        let fetchRequest: NSFetchRequest<ToDoItemEntity> = ToDoItemEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        do {
            let result = try self.context.fetch(fetchRequest)
            if let itemToUpdate = result.first {
                itemToUpdate.title = item.title
                itemToUpdate.text = item.description
                itemToUpdate.isCompleted = item.isCompleted
            }
        } catch {
            print("Data saving error")
        }

        appDelegate.saveContext()
    }

    func updateToDoCompletionStatus(withId id: UUID) {
        let fetchRequest: NSFetchRequest<ToDoItemEntity> = ToDoItemEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let result = try self.context.fetch(fetchRequest)
            result.first?.isCompleted.toggle()
        } catch {
            print("To-do not found in Core Data for status update")
        }

        appDelegate.saveContext()
    }

    // MARK: - Deleting Data
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
