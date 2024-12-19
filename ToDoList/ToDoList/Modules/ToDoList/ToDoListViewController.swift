//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 05.12.2024.
//

import UIKit

protocol ToDoListViewProtocol: AnyObject {
    func updateTableToDoList(model: [ToDoItem])
    func updateNumberToDo(items: String)
    func startLoader()
    func stopLoader()
}

final class ToDoListViewController: UIViewController {
    private let presenter: ToDoListPresenterProtocol
    private lazy var customView = ToDoListView()

    init(presenter: ToDoListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        presenter.viewDidLoad()
    }

    func setupNavBar() {
        title = presenter.title
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.whiteToDo
        ]

        navigationController?.navigationBar.barStyle = .black
        setNeedsStatusBarAppearanceUpdate()

        navigationItem.searchController = searchController
        self.navigationController?.navigationBar.backgroundColor = .blackToDo
    }

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
}

extension ToDoListViewController: ToDoListViewProtocol {
    func updateTableToDoList(model: [ToDoItem]) {
        customView.updateTableToDoList(model: model)
    }
    
    func updateNumberToDo(items: String) {
        customView.updateNumberToDo(items: items)
    }
    
    func startLoader() {
        customView.startLoader()
    }
    
    func stopLoader() {
        customView.stopLoader()
    }

}

