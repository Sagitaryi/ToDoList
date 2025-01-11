//
//  ToDoListTableManager.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 10.12.2024.
//

import UIKit

final class ToDoListTableManager: NSObject {
    var tapStatusButton: ((_ id: UUID) -> Void)?

    private weak var tableView: UITableView?
    private var items: [ToDoItem] = []
    private var diffableDataSource: UITableViewDiffableDataSource<Int, ToDoItem>?

    // MARK: - Public Methods
    func set(tableView: UITableView) {
        tableView.delegate = self
        self.tableView = tableView
        setupDifableDataSource()
    }

    func bind(items: [ToDoItem]) {
        self.items = items
        updateDiffableDataSource()
    }

    func updateDiffableDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ToDoItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        diffableDataSource?.apply(snapshot, animatingDifferences: false)
    }
}

extension ToDoListTableManager: UITableViewDelegate {
    // MARK: - UITableViewDelegate Methods

}

private extension ToDoListTableManager {
    // MARK: - Private Methods
    func setupDifableDataSource() {
        guard let tableView = tableView else { return }
        diffableDataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, _ in
            let row = indexPath.row

            guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListTableViewCell.id) as? ToDoListTableViewCell,
                  self.items.indices.contains(row)
            else {
                return UITableViewCell()
            }
            let item = self.items[row]

            let cellModel = ToDoItem(id: item.id,
                                     title: item.title,
                                     description: item.description,
                                     createdAt: item.createdAt,
                                     isCompleted: item.isCompleted
            )
            cell.selectionStyle = .none

            cell.configure(with: cellModel) {
                guard let tapStatusButton = self.tapStatusButton else { return }
                tapStatusButton(item.id)
            }
            return cell
        })
    }
}
