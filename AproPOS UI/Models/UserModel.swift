//
//  UserModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 21/5/22.
//

import Foundation

struct UserModel: Identifiable {
    let id = UUID()
    var email: String
    var firstName: String
    var lastName: String
    var role: String
}
