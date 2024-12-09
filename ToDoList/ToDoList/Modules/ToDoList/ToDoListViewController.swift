//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 05.12.2024.
//

import UIKit

final class ToDoListViewController: UIViewController {
        private lazy var customView = ToDoListView()
    
        override func loadView() {
            view = customView
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setupNavBar()
        }


    func setupNavBar() {
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.whiteToDo
        ]

        navigationController?.navigationBar.barStyle = .black
        setNeedsStatusBarAppearanceUpdate()

        navigationItem.searchController = UISearchController()
        self.navigationController?.navigationBar.backgroundColor = .blackToDo
    }

}
