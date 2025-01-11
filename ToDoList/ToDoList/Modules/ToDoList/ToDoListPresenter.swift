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
    func updateToDoCompletionStatus(toDoId: UUID)
    func searchItems(with query: String)
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

        interactor.fetchToDoItems { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(model):
                updateTableView(with: model)
                updateCountToDo(numbers: model.count)
                view?.stopLoader()
            case let .failure(error):
                print(error)
            }
        }
    }

    func updateToDoCompletionStatus(toDoId: UUID) {
        let items = interactor.updateToDoCompletionStatus(toDoId: toDoId)
        updateTableView(with: items)
    }

    func searchItems(with query: String) {
        let result = interactor.searchItems(with: query)
        updateCountToDo(numbers: result.count)
        updateTableView(with: result)
    }
}

// MARK: - Private Methods
private extension ToDoListPresenter {
    func updateCountToDo(numbers: Int) {
        view?.updateNumberToDo(items: "\(numbers) Задач")
    }

    func updateTableView(with model: [ToDoItem]) {
        view?.updateTableToDoList(model: model)
    }
}
