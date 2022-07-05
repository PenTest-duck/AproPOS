//
//  Repository.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import UIKit // for UIImage


class UserRepository: ObservableObject {
    //@Published var createAccountSuccess = false
    //@Published var createAccountError = "" // Contains create account error message
    
    private let db = Firestore.firestore()
    
    func addUser(user: UserModel) -> String {
        let docRef = db.collection("users").document(user.id!)
        
        do {
            try docRef.setData(from: user)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }
}
