//
//  NoteDetailView.swift
//  WA7_Wang_0532
//
//  Created by jocw on 10/27/24.
//

import UIKit

class NoteDetailView: UIView {
    
    var noteTextView: UITextView!
    var deleteButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupNoteTextView()
        setupDeleteButton()
        initConstraints()
    }
    
    func setupNoteTextView() {
        noteTextView = UITextView()
        noteTextView.isEditable = false
        noteTextView.font = .systemFont(ofSize: 16)
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(noteTextView)
    }
    
    func setupDeleteButton() {
        deleteButton = UIButton(type: .system)
        deleteButton.setTitle("delete", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deleteButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            noteTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            noteTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            noteTextView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -20),
            
            deleteButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 200),
            deleteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
