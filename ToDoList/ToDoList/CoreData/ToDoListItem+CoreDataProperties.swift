//
//  ToDoListItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 06.12.2024.
//
//

import Foundation
import CoreData

@objc(ToDoListItem)
public class ToDoListItem: NSManagedObject {}

extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var isCompleted: Bool
}

extension ToDoListItem: Identifiable {}
