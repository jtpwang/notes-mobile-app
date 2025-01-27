//
//  NoteDetailViewController.swift
//  WA7_Wang_0532
//
//  Created by jocw on 10/27/24.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    let detailView = NoteDetailView()
    var note: Note! // Note to display, from prev screen
    var deleteCallback: ((String) -> Void)? // Callback func to handle note deletion
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Note detail"
        setupNote() // Note content
        setupActions() // Delete button action
    }
    
    // Displays content of note in text view
    private func setupNote() {
        detailView.noteTextView.text = note.text
    }
    
    // Delete button acation
    private func setupActions() {
        detailView.deleteButton.addTarget(self, action: #selector(onDeleteTapped), for: .touchUpInside)
    }
    
    // Action when delete button tapped
    @objc private func onDeleteTapped() {
        // Confirm alert
        let alert = UIAlertController(title: "Confirm delete",
                                    message: "Are you sure you want to delete this note?",
                                    preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            // Call deleteCallback with the note ID to handle deletion
            self.deleteCallback?(self.note._id)
            // Navigate back to prev screen after deleting
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true) // Present alert
    }
}
