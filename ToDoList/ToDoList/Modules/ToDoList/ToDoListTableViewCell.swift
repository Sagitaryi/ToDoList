//
//  ToDoListTableViewCell.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 10.12.2024.
//

import UIKit

final class ToDoListTableViewCell: UITableViewCell {
    static let id = "ToDoListTableViewCell"

    var tapStatusButton: (() -> Void)?

    // MARK: - UI Elements
    private var toDoDetailsView: UIView = {
        let view = UIView()
        return view
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()

    private var createAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayToDo
        return label
    }()

    private lazy var statusButtonImageView: CustomImageView = {
        let button = CustomImageView()
        button.isUserInteractionEnabled = true

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(statusButtonTapped))
        button.addGestureRecognizer(recognizer)
        return button
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func configure(with model: ToDoItem, onTapStatusButton: (() -> ())?) {
        tapStatusButton = onTapStatusButton
        if model.isCompleted {
            statusButtonImageView.image = UIImage(named: "completed.png")

            titleLabel.attributedText = model.title.strikeThrough()
            titleLabel.textColor = .grayToDo
            descriptionLabel.textColor = .grayToDo
        } else {
            statusButtonImageView.image = UIImage(named: "notCompleted.png")

            titleLabel.attributedText = model.title.applyDefault()
            descriptionLabel.textColor = .whiteToDo
        }
        descriptionLabel.text = model.description
        createAtLabel.text = "\(model.createdAt)"
    }
}

private extension ToDoListTableViewCell {
    // MARK: - Constants
    enum ConstantsConstraint {
        static let sizeStatusButton: CGFloat = 25
        static let distanceToSide: CGFloat = 18
        static let spacingBetweenContent: CGFloat = 10
    }

    // MARK: - Setup Methods
    func setupCell() {
        contentView.backgroundColor = .blackToDo
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        contentView.addSubview(statusButtonImageView)

        contentView.addSubview(toDoDetailsView)
        toDoDetailsView.addSubview(titleLabel)
        toDoDetailsView.addSubview(descriptionLabel)
        toDoDetailsView.addSubview(createAtLabel)

        contentView.bringSubviewToFront(statusButtonImageView)
    }

    func setupConstraints() {
        statusButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        toDoDetailsView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        createAtLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            statusButtonImageView.heightAnchor.constraint(equalToConstant: ConstantsConstraint.sizeStatusButton),
            statusButtonImageView.widthAnchor.constraint(equalToConstant: ConstantsConstraint.sizeStatusButton),
            statusButtonImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            statusButtonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantsConstraint.distanceToSide),

            toDoDetailsView.leadingAnchor.constraint(equalTo: statusButtonImageView.trailingAnchor, constant: ConstantsConstraint.spacingBetweenContent),
            toDoDetailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstantsConstraint.distanceToSide),
            toDoDetailsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            toDoDetailsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: toDoDetailsView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: toDoDetailsView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: toDoDetailsView.topAnchor, constant: ConstantsConstraint.spacingBetweenContent),

            descriptionLabel.leadingAnchor.constraint(equalTo: toDoDetailsView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: toDoDetailsView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ConstantsConstraint.spacingBetweenContent),

            createAtLabel.leadingAnchor.constraint(equalTo: toDoDetailsView.leadingAnchor),
            createAtLabel.trailingAnchor.constraint(equalTo: toDoDetailsView.trailingAnchor),
            createAtLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: ConstantsConstraint.spacingBetweenContent),
            createAtLabel.bottomAnchor.constraint(equalTo: toDoDetailsView.bottomAnchor, constant: -ConstantsConstraint.spacingBetweenContent),
        ])
    }

    // MARK: - Actions
    @objc func statusButtonTapped() {
        tapStatusButton?()
    }
}
