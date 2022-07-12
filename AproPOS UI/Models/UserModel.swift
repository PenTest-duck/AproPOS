//
//  UserModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 21/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel: Identifiable, Codable, Equatable {
    @DocumentID public var id: String? // unique email
    var firstName: String
    var lastName: String
    var role: String            // staff, manager, owner
    var wage: Decimal
    var phone: String
    var comment: String
    
    init(id: String = UUID().uuidString, firstName: String, lastName: String, role: String = "staff", wage: Decimal = 0.00, phone: String = "", comment: String = "") {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.role = role
        self.wage = wage
        self.phone = phone
        self.comment = comment
    }
}
