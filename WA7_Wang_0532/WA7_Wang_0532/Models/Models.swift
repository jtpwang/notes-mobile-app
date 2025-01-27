//
//  Models.swift
//  WA7_Wang_0532
//
//  Created by jocw on 10/27/24.
//

import Foundation

// Struct representing a user
struct User: Codable {
    let name: String
    let email: String
}

// Struct representing a note
struct Note: Codable {
    let _id: String
    let text: String
}

// Struct representing an authentication token
struct AuthToken: Codable {
    let token: String
}

// Struct representing a response of an array of notes
struct NotesResponse: Codable {
    let notes: [Note]
}

