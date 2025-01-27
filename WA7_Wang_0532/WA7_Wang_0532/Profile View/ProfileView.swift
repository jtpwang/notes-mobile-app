//
//  ProfileView.swift
//  WA7_Wang_0532
//
//  Created by jocw on 10/27/24.
//

import UIKit

class ProfileView: UIView {

    // UI Elements
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var logoutButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupNameLabel()
        setupEmailLabel()
        setupLogoutButton()
        initConstraints()
    }

    // Setup name label
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }

    // Setup email label
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }

    // Setup logout button
    func setupLogoutButton() {
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoutButton)
    }

    // Initialize Constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Name label constraints
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            // Email label constraints
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            // Logout button constraints
            logoutButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 40),
            logoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    // Required Initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
