//
//  UserModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 21/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel: Identifiable, Codable {
    @DocumentID public var id: String?
    var email: String
    var firstName: String
    var lastName: String
    var role: String
    
    init(id: String = UUID().uuidString, email: String, firstName: String, lastName: String, role: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.role = role
    }
}
