//
//  NotesViewController.swift
//  WA7_Wang_0532
//
//  Created by jocw on 10/27/24.
//

import UIKit
import Alamofire

class NotesViewController: UIViewController {
    
    
    private let notesView = NotesView()
    // Array to store the notes
    private var notes: [Note] = []

    override func loadView() {
        self.view = notesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupActions()
        fetchNotes()
    }

    // Prevent back navigation by hiding back button
    private func setupUI() {
        navigationItem.hidesBackButton = true
    }
    
    private func setupActions() {
        notesView.addNoteButton.addTarget(self, action: #selector(onAddNoteTapped), for: .touchUpInside)
        notesView.profileButton.addTarget(self, action: #selector(onProfileButtonTapped), for: .touchUpInside)
    }

    // Sets up the table view to display notes
    private func setupTableView() {
        notesView.tableView.delegate = self
        notesView.tableView.dataSource = self
        notesView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoteCell")
    }

    // Navigates to profile screen when profile button is tapped
    @objc private func onProfileButtonTapped() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }

    // Adds a new note when add note button tapped
    @objc private func onAddNoteTapped() {
        addNote()
    }

    // Handles delete button tap action
    @objc private func onDeleteButtonTapped(_ sender: UIButton) {
        // Get the index of the note to delete
        let noteIndex = sender.tag
        // Get the note to delete
        let noteToDelete = notes[noteIndex]

        // Confirmation alert
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this note?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { _ in
            self.deleteNote(noteId: noteToDelete._id) // Call delete function
        }))
        present(alert, animated: true, completion: nil)
    }



    // Fetches notes from the server
    private func fetchNotes() {
        let token = UserDefaults.standard.string(forKey: "authToken") ?? ""
        let headers: HTTPHeaders = ["x-access-token": token]

        AF.request(APIConfigs.baseNoteURL + "getall", method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                if let notesResponse = try? JSONDecoder().decode(NotesResponse.self, from: data) {
                    self.notes = notesResponse.notes // Update notes array
                    self.notesView.tableView.reloadData() // Refresh table view
                }
            case .failure(let error):
                print("Failed to fetch notes:", error.localizedDescription)
            }
        }
    }

    // Adds a new note to the server
    private func addNote() {
        guard let text = notesView.noteTextField.text, !text.isEmpty else { return }

        let token = UserDefaults.standard.string(forKey: "authToken") ?? ""
        let headers: HTTPHeaders = ["x-access-token": token]
        let parameters: [String: String] = ["text": text]

        AF.request(APIConfigs.baseNoteURL + "post", method: .post, parameters: parameters, headers: headers).response { response in
            switch response.result {
            case .success:
                self.fetchNotes() // Refresh notes after addition
                self.notesView.noteTextField.text = "" // Clear the text field
            case .failure(let error):
                print("Failed to add note:", error.localizedDescription)
            }
        }
    }

    // Deletes a note from the server
    private func deleteNote(noteId: String) {
        let token = UserDefaults.standard.string(forKey: "authToken") ?? ""
        let headers: HTTPHeaders = ["x-access-token": token]
        let parameters: [String: String] = ["id": noteId]

        AF.request(APIConfigs.baseNoteURL + "delete", 
                method: .post, 
                parameters: parameters,
                headers: headers).response { response in
            switch response.result {
            case .success:
                self.fetchNotes() // Refresh notes after deletion
            case .failure(let error):
                print("Failed to delete note:", error.localizedDescription)
            }
        }
    }
}

// Table View Delegate and Data Source
extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    // Returns the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].text

        // Add delete button to each cell
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete", for: .normal)
        // Set button tag to the current row index
        deleteButton.tag = indexPath.row
        deleteButton.addTarget(self, action: #selector(onDeleteButtonTapped(_:)), for: .touchUpInside)

        deleteButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
    
        // Add button as accessory view of cell
        cell.accessoryView = deleteButton

        return cell
    }

    // Cell selection to navigate to note details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = NoteDetailViewController()
        detailVC.note = notes[indexPath.row]
        detailVC.deleteCallback = { [weak self] noteId in
            self?.deleteNote(noteId: noteId)
        }
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Handles swipe-to-delete action
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteId = notes[indexPath.row]._id
            deleteNote(noteId: noteId)
        }
    }
}
