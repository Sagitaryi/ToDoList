//
//  ViewController.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 05.12.2024.
//

import UIKit

final class ToDoListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackToDo

        let toDoListService = ToDoListService()
        toDoListService.fetchToDoList { result in
            switch result {
            case let .success(data):
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }


}

