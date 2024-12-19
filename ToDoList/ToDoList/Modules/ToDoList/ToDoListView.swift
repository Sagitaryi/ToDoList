//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 09.12.2024.
//
import UIKit

final class ToDoListView: UIView {
    private let tableManager = ToDoListTableManager()

    // MARK: - UI Elements
    private lazy var bottomBlockContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrayToDo
        return view
    }()

    private lazy var bottomBlockActionView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrayToDo
        return view
    }()

    private lazy var countAllToDoLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 11)
        label.textColor = .whiteToDo
        return label
    }()

    private lazy var createNewToDoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "createNewToDoItem.png"), for: .normal)
        button.addTarget(self, action: #selector(showScreenToCreateNewTask), for: .touchUpInside)
        return button
    }()

    private lazy var toDoListTableView: UITableView = {
        let table = UITableView()

        table.register(
            ToDoListTableViewCell.self,
            forCellReuseIdentifier: ToDoListTableViewCell.id
        )
        table.separatorInset = .zero
        table.tableFooterView = UIView()
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.separatorColor = .grayToDo
        table.showsVerticalScrollIndicator = false

        tableManager.set(tableView: table)
        tableManager.tapStatusButton = { [weak self] index in
            print("index: \(index.row)")
        }
        return table
    }()

    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        backgroundColor = .blackToDo
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTableToDoList(model: [ToDoItem]) {
        tableManager.bind(items: model)
    }

    func updateNumberToDo(items: String) {
        countAllToDoLabel.text = items
    }

    func startLoader() {
        print("Start Loader")
    }

    func stopLoader() {
        print("Stop Loader")
    }

}

private extension ToDoListView {
    // MARK: - UI Actions
    @objc
    func showScreenToCreateNewTask() {
        print("showScreenToCreateNewTask")
    }

    // MARK: - Setup Methods
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        addSubview(bottomBlockContentView)
        bottomBlockContentView.addSubview(bottomBlockActionView)
        bottomBlockContentView.addSubview(countAllToDoLabel)
        bottomBlockContentView.addSubview(createNewToDoButton)

        addSubview(toDoListTableView)
    }

    func setupConstraints() {
        bottomBlockContentView.translatesAutoresizingMaskIntoConstraints = false
        bottomBlockActionView.translatesAutoresizingMaskIntoConstraints = false
        countAllToDoLabel.translatesAutoresizingMaskIntoConstraints = false
        createNewToDoButton.translatesAutoresizingMaskIntoConstraints = false
        toDoListTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bottomBlockContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomBlockContentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bottomBlockContentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            bottomBlockContentView.heightAnchor.constraint(equalToConstant: 80),

            bottomBlockActionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomBlockActionView.leadingAnchor.constraint(equalTo: bottomBlockContentView.leadingAnchor),
            bottomBlockActionView.trailingAnchor.constraint(equalTo: bottomBlockContentView.trailingAnchor),
            bottomBlockActionView.topAnchor.constraint(equalTo: bottomBlockContentView.topAnchor),

            countAllToDoLabel.centerXAnchor.constraint(equalTo: bottomBlockActionView.centerXAnchor),
            countAllToDoLabel.centerYAnchor.constraint(equalTo: bottomBlockActionView.centerYAnchor),

            createNewToDoButton.widthAnchor.constraint(equalToConstant: 40),
            createNewToDoButton.heightAnchor.constraint(equalToConstant: 40),
            createNewToDoButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createNewToDoButton.centerYAnchor.constraint(equalTo: bottomBlockActionView.centerYAnchor),

            toDoListTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            toDoListTableView.bottomAnchor.constraint(equalTo: bottomBlockContentView.topAnchor, constant: 0),
            toDoListTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            toDoListTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
