//
//  LoginViewController.swift
//  WA7_Wang_0532
//
//  Created by jocw on 10/27/24.

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    let loginView = LoginView()

    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions() // For login and register
        checkUserSession() // Check if session is user active
    }

    // Setup Button Actions
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
    }

    // Called when login button is tapped, login process
    @objc private func onLoginTapped() {
        loginUser()
    }

    // Called when register button is tapped, registration process
    @objc private func onRegisterTapped() {
        registerUser()
    }

    // Tries to login with email + password
    private func loginUser() {
        // Ensure fields not empty
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text else { return }

        // Login parameters
        let parameters: [String: String] = ["email": email, "password": password]
        // POST request
        AF.request(APIConfigs.baseAuthURL + "login", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseData { response in
            switch response.result {
            case .success(let data):
                // Decode response data- AuthToken
                if let token = try? JSONDecoder().decode(AuthToken.self, from: data) {
                    // Save token for UserDefaults
                    UserDefaults.standard.set(token.token, forKey: "authToken")
                    self.navigateToNotes() // Success
                } else {
                    if response.response?.statusCode == 404 {
                        self.loginView.statusLabel.text = "User not found."
                    } else if response.response?.statusCode == 401 {
                        self.loginView.statusLabel.text = "Incorrect password."
                    } else {
                        self.loginView.statusLabel.text = "Login failed."
                    }
                }
            case .failure:
                self.loginView.statusLabel.text = "Network error."
            }
        }
    }

    // Register a new user with name, email, and password
    private func registerUser() {
        // Ensure fields not empty
        guard let name = loginView.nameTextField.text,
              let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text else { return }

        // Email validation
        guard isValidEmail(email) else {
            loginView.statusLabel.text = "Please enter a valid email address."
            return
        }

        // Parameters for registration request
        let parameters: [String: String] = ["name": name, "email": email, "password": password]
        // Send a POST request
        AF.request(APIConfigs.baseAuthURL + "register",
                   method: .post,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder.default).response { response in
            if response.response?.statusCode == 200 {
                self.loginView.statusLabel.text = "Registration successful."
            } else if response.response?.statusCode == 409 {
                self.loginView.statusLabel.text = "User already exists."
            } else {
                self.loginView.statusLabel.text = "Registration failed."
            }
        }
    }

    // Checks if a user session exists by looking for an auth token
    private func checkUserSession() {
        if let _ = UserDefaults.standard.string(forKey: "authToken") {
            navigateToNotes()
        }
    }

    // Navigates to Notes screen if success
    private func navigateToNotes() {
        let notesVC = NotesViewController()
        navigationController?.pushViewController(notesVC, animated: true)
    }

    // Email validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
