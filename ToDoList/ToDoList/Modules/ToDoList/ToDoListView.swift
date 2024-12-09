//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 09.12.2024.
//
import UIKit

final class ToDoListView: UIView {

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
        label.text = "N задач"
        return label
    }()

    private lazy var createNewToDoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "createNewToDoItem.png"), for: .normal)
        button.addTarget(self, action: #selector(showScreenToCreateNewTask), for: .touchUpInside)
        return button
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
    }

    func setupConstraints() {
        bottomBlockContentView.translatesAutoresizingMaskIntoConstraints = false
        bottomBlockActionView.translatesAutoresizingMaskIntoConstraints = false
        countAllToDoLabel.translatesAutoresizingMaskIntoConstraints = false
        createNewToDoButton.translatesAutoresizingMaskIntoConstraints = false

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
        ])

    }
}
