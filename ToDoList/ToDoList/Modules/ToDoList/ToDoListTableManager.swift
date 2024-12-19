//
//  ToDoListTableManager.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 10.12.2024.
//

import UIKit

final class ToDoListTableManager: NSObject {
    var tapStatusButton: ((_ indexPath: IndexPath) -> Void)?

    private weak var tableView: UITableView?
    private var items: [ToDoItem]?
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
        guard let items = items else { return }
        snapshot.appendItems(items)
        diffableDataSource?.apply(snapshot, animatingDifferences: false)
    }
}

extension ToDoListTableManager: UITableViewDelegate {
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tapStatusButton?(indexPath)
    }
}

private extension ToDoListTableManager {
    // MARK: - Private Methods
    func setupDifableDataSource() {
        guard let tableView = tableView else { return }
        diffableDataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, _ in
            let row = indexPath.row
            guard let items = self.items,
                  items.indices.contains(row), let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListTableViewCell.id) as? ToDoListTableViewCell
            else {
                return UITableViewCell()
            }
            let item = items[row]

            let cellModel = ToDoItem(id: item.id,
                                     title: item.title,
                                     description: item.description,
                                     createdAt: item.createdAt,
                                     isCompleted: item.isCompleted
            )

            cell.configure(with: cellModel)
            return cell
        })
    }
}
