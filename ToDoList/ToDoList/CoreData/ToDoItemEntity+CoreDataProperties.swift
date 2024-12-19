//
//  ToDoItemEntity+CoreDataProperties.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 12.12.2024.
//
//
import Foundation
import CoreData

@objc(ToDoItemEntity)
public class ToDoItemEntity: NSManagedObject {}

extension ToDoItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItemEntity> {
        return NSFetchRequest<ToDoItemEntity>(entityName: "ToDoItemEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID
    @NSManaged public var isCompleted: Bool
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

extension ToDoItemEntity : Identifiable {

}
