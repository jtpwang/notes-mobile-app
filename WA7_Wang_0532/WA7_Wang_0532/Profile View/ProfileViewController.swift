//
//  ProfileViewController.swift
//  WA7_Wang_0532
//
//  Created by jocw on 10/27/24.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    let profileView = ProfileView()

    override func loadView() {
        self.view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions() // Set up button actions for logout
        fetchUserProfile()
    }

    // Setup Logout Button Action
    private func setupActions() {
        profileView.logoutButton.addTarget(self, action: #selector(onLogoutTapped), for: .touchUpInside)
    }

    // Action for logging out the user
    @objc private func onLogoutTapped() {
        // Remove authToken from UserDefaults
        UserDefaults.standard.removeObject(forKey: "authToken")
        navigationController?.popToRootViewController(animated: true)
    }

    // Action for navigating back to prev screen
    @objc private func onBackTapped() {
        navigationController?.popViewController(animated: true)
    }

    // Fetch User Profile
    private func fetchUserProfile() {
        // Retrieve auth token from UserDefaults
        let token = UserDefaults.standard.string(forKey: "authToken") ?? ""
        // Set up headers with the token
        let headers: HTTPHeaders = ["x-access-token": token]

        // Send a GET request to fetch user profile
        AF.request(APIConfigs.baseAuthURL + "me", method: .get, headers: headers).responseData { response in
            if let data = response.data, let user = try? JSONDecoder().decode(User.self, from: data) {
                // Update profile view with user's name, email
                self.profileView.nameLabel.text = user.name
                self.profileView.emailLabel.text = user.email
            } else {
                // Handle error
                self.profileView.nameLabel.text = "Failed to fetch user profile."
                self.profileView.emailLabel.text = ""
            }
        }
    }
}
