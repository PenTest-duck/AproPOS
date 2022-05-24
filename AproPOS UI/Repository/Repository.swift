//
//  Repository.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class UserRepository: ObservableObject {
    @Published var createAccountSuccess = false
    @Published var createAccountError = "" // Contains create account error message
    
    private let db = Firestore.firestore()
    
    func addUser(user: UserModel) {
        let docRef = db.collection("users").document(user.id!)
        
        do {
            try docRef.setData(from: user)
            createAccountSuccess = true
        } catch {
            createAccountSuccess = false
            createAccountError = error.localizedDescription
        }
    }
}
