//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 09.12.2024.
//

import UIKit

protocol ToDoListPresenterProtocol {
    var title: String { get }

    func viewDidLoad()
}

final class ToDoListPresenter: ToDoListPresenterProtocol {
    // MARK: - Properties
    weak var view: ToDoListViewProtocol?

    var title: String { "Задачи" }

    private let interactor: ToDoListInteractorProtocol
    private let router: ToDoListRouterProtocol

    // MARK: - Initializer
    init(view: ToDoListViewProtocol? = nil, interactor: ToDoListInteractorProtocol, router: ToDoListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods
    func viewDidLoad() {
        view?.startLoader()

        var toDoModel = [ToDoItem]()
        
        interactor.fetchToDoItems { [self] result in
            print("Stop")
            switch result {
            case let .success(model):
                toDoModel = model
                view?.updateTableToDoList(model: toDoModel)
                updateCountToDo(numbers: toDoModel.count)
            case let .failure(error):
                print(error)
            }
        }
    }

    func updateCountToDo(numbers: Int) {
        view?.updateNumberToDo(items: "\(numbers) Задач")
    }

}
