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
import UIKit // for UIImage


class UserRepository: ObservableObject {
    private let db = Firestore.firestore()
    var users = [UserModel]()
    
    func addUser(user: UserModel) -> String {
        let docRef = db.collection("users").document(user.id!)
        
        do {
            try docRef.setData(from: user)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }
    
    func fetchUsers(completion: @escaping ([UserModel]) -> Void) {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.users = documents.map { queryDocumentSnapshot -> UserModel in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let role = data["role"] as? String ?? "staff"
                let wage = data["wage"] as? Double ?? 0.00
                let phone = data["phone"] as? String ?? ""
                let comment = data["comment"] as? String ?? ""

                return UserModel(id: id, firstName: firstName, lastName: lastName, role: role, wage: Decimal(wage), phone: phone, comment: comment)
            }
            
            print(self.users)
            completion(self.users)
        }
    }
    
    func removeUser(email: String) {
        db.collection("users").document(email).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func staffRBAC(email: String, view: String) -> Bool {
        let staffDisallowed = ["ManagementView", "MenuView", "InventoryView", "StaffView", "AnalyticsView"]
        let managerDisallowed = ["StaffView", "AnalyticsView"]
        
        let user = self.users.first(where: { $0.id == email } )
        var isAllowed: Bool

        switch user!.role {
            case "staff":
                isAllowed = staffDisallowed.contains(view) ? false : true
            case "manager":
                isAllowed = managerDisallowed.contains(view) ? false : true
            default: // owner
                isAllowed = true
        }
        
        return isAllowed
    }
}
