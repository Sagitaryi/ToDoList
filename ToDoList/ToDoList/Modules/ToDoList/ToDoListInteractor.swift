//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 09.12.2024.
//

import UIKit

protocol ToDoListInteractorProtocol {
    func fetchToDoItems(completion: @escaping (Result<[ToDoItem], Error>) -> Void)
    func updateToDoCompletionStatus(toDoId: UUID) -> [ToDoItem]
    func searchItems(with query: String) -> [ToDoItem]
}

final class ToDoListInteractor: ToDoListInteractorProtocol {
    // MARK: - Properties
    private let toDoListService: ToDoListServiceProtocol
    private let coreDataManager: CoreDataManagerProtocol
    private var searchQuery: String?

    // MARK: - Initializer
    init(toDoListService: ToDoListServiceProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.toDoListService = toDoListService
        self.coreDataManager = coreDataManager
    }

    // MARK: - Data Handling Method
    func fetchToDoItems(completion: @escaping (Result<[ToDoItem], Error>) -> Void) {
        let dataFromCoreData = coreDataManager.getAllItems()

        if dataFromCoreData.isEmpty {
            print("isEmpty")
            toDoListService.fetchToDoList(queue: .main) { result in
                switch result {
                case let .success(data):
                    self.saveReceivedDataToCoreData(data: data.toDoList)
                    completion(.success(data.toDoList))
                case let .failure(error):
                    print(error)
                }
            }
        } else {
            let toDoModel = convert(model: dataFromCoreData)
            completion(.success(toDoModel))
        }
    }

    // MARK: - ToDo Completion Status
    func updateToDoCompletionStatus(toDoId: UUID) -> [ToDoItem] {
        coreDataManager.updateToDoCompletionStatus(withId: toDoId)
        let items: [ToDoItem]
        if let query = searchQuery, searchQuery != "" {
            items = searchItems(with: query)
        } else {
            items = convert(model: coreDataManager.getAllItems())
        }
        return items
    }

    func searchItems(with query: String) -> [ToDoItem] {
        searchQuery = query
        let result: [ToDoItemEntity]
        if query.isEmpty {
            result = coreDataManager.getAllItems()
        } else {
            result = coreDataManager.searchItems(with: query)
        }
        return convert(model: result)
    }
}

private extension ToDoListInteractor {
    // MARK: - CoreData Operations
    func saveReceivedDataToCoreData(data: [ToDoItem]) {
        data.forEach { item in
            coreDataManager.createItem(with: item)
        }
    }

    // MARK: - Model Conversion
    func convert(model: [ToDoItemEntity]) -> [ToDoItem] {
        let newModel = model.map { item in
            ToDoItem(id: item.id,
                     title: item.title ?? "",
                     description: item.text ?? "",
                     createdAt: item.date ?? Date(),
                     isCompleted: item.isCompleted
            )
        }
        return newModel
    }
}
