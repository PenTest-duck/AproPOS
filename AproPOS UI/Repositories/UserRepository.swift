//
//  UserRepository.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import UIKit // only for UIImage


class UserRepository: ObservableObject {
    // Create a reference to the Firestore database, and an array of users
    private let db = Firestore.firestore()
    var users = [UserModel]()
    
    // Add a new user to the database
    func addUser(user: UserModel) -> String {
        let docRef = db.collection("users").document(user.id!)
        
        do {
            try docRef.setData(from: user)
            return "success"
        } catch { // Error handling
            return error.localizedDescription
        }
    }
    
    // Retrieve users data from Firestore and return an array of all users
    func fetchUsers(completion: @escaping ([UserModel]) -> Void) {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in // Asynchronous update automatically when values change
            // Error handling when there are no documents in the collection
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            // Map retrieved data to an array of individual UserModels
            self.users = documents.map { queryDocumentSnapshot -> UserModel in
                let data = queryDocumentSnapshot.data()
                
                // Extract values in data to variables
                let id = queryDocumentSnapshot.documentID
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let role = data["role"] as? String ?? "staff"
                let wage = data["wage"] as? Double ?? 0.00
                let phone = data["phone"] as? String ?? ""
                let comment = data["comment"] as? String ?? ""

                // Add constructed UserModels to users
                return UserModel(id: id, firstName: firstName, lastName: lastName, role: role, wage: Decimal(wage), phone: phone, comment: comment)
            }
            
            // Return the orders when Firebase requests complete
            print(self.users)
            completion(self.users)
        }
    }
    
    // Remove an existing user from the database
    func removeUser(email: String) {
        db.collection("users").document(email).delete() { err in
            // Error handling
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    // Check if a certain user is permitted into a certain view, according to their role
    func staffRBAC(email: String, view: String) -> Bool {
        // Define RBAC blacklist of views
        let staffDisallowed = ["ManagementView", "MenuView", "InventoryView", "StaffView", "AnalyticsView"]
        let managerDisallowed = ["StaffView", "AnalyticsView"]
        
        // Get the user object by email address
        let user = self.users.first(where: { $0.id == email } )
        var isAllowed: Bool

        // Determine true or false for permission to access a certain view
        switch user!.role {
            case "staff":
                isAllowed = staffDisallowed.contains(view) ? false : true
            case "manager":
                isAllowed = managerDisallowed.contains(view) ? false : true
            default: // owner
                isAllowed = true
        }
        
        return isAllowed // true or false
    }
}
