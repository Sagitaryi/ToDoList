//
//  ToDoListFactory.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 09.12.2024.
//

import UIKit

final class ToDoListFactory {
    func make() -> UIViewController {
        let networkClient = NetworkClient()
        let toDoListService = ToDoListService(networkClient: networkClient)
        let coreDataManager = CoreDataManager()

        let interactor = ToDoListInteractor(toDoListService: toDoListService, coreDataManager: coreDataManager)
        let router = ToDoListRouter()
        let presenter = ToDoListPresenter(interactor: interactor,
                                          router: router)

        let viewController = ToDoListViewController(presenter: presenter)

        presenter.view = viewController

        return viewController
    }
}
