//
//  NotesView.swift
//  WA7_Wang_0532
//
//  Created by jocw on 10/27/24.
//

import UIKit

class NotesView: UIView {

    // UI Elements
    var tableView: UITableView!
    var noteTextField: UITextField!
    var addNoteButton: UIButton!
    var profileButton: UIButton!

    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUI()
        initConstraints()
    }
    
    private func setupUI() {
        setupTableView()
        setupProfileButton()
        setupNoteTextField()
        setupAddNoteButton()
    }

    // Setup table view
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
    }

    // Setup note text field
    func setupNoteTextField() {
        noteTextField = UITextField()
        noteTextField.placeholder = "Enter your note"
        noteTextField.borderStyle = .roundedRect
        noteTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(noteTextField)
    }

    // Setup add note button
    func setupAddNoteButton() {
        addNoteButton = UIButton(type: .system)
        addNoteButton.setTitle("Add Note", for: .normal)
        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addNoteButton)
    }

    // Setup profile button
    func setupProfileButton() {
        profileButton = UIButton(type: .system) 
        profileButton.setTitle("View Profile", for: .normal)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileButton)
    }

    // Initialize Constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Profile button constraints
            profileButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            // Table view constraints
            tableView.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: noteTextField.topAnchor, constant: -10),

            // Input field and button constraints
            noteTextField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            noteTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            noteTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            addNoteButton.topAnchor.constraint(equalTo: noteTextField.bottomAnchor, constant: 8),
            addNoteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addNoteButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    // Required Initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
