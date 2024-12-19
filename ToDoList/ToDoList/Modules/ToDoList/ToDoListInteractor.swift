//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 09.12.2024.
//

import UIKit

protocol ToDoListInteractorProtocol {
    func fetchToDoItems(completion: @escaping (Result<[ToDoItem], Error>) -> Void)
}

final class ToDoListInteractor: ToDoListInteractorProtocol {
    // MARK: - Properties
    private let toDoListService: ToDoListServiceProtocol
    private let coreDataManager: CoreDataManagerProtocol

    // MARK: - Initializer
    init(toDoListService: ToDoListServiceProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.toDoListService = toDoListService
        self.coreDataManager = coreDataManager
    }

    // MARK: - Data Handling Methods
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

    func saveReceivedDataToCoreData(data: [ToDoItem]) {
        data.forEach { item in
            coreDataManager.createItem(with: item)
        }
    }

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
