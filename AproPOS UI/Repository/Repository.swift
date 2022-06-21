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

class OrderRepository: ObservableObject {
    // From: https://peterfriese.dev/posts/swiftui-firebase-fetch-data/
    private let db = Firestore.firestore()
    var orders = [OrderModel]()

    func fetchOrders() -> [OrderModel] {
        db.collection("orders").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.orders = documents.map { queryDocumentSnapshot -> OrderModel in
                let data = queryDocumentSnapshot.data()
                let tableNumber = data["tableNumber"] as? Int ?? 0
                let startTimeEvent = data["startTimeEvent"] as? Date ?? Date() // nil
                let status = data["status"] as? String ?? ""
                let orderedMenuItems = data["orderedMenuItems"] as? [String: Int] ?? [:]

                return OrderModel(tableNumber: tableNumber, startTimeEvent: startTimeEvent, status: status, orderedMenuItems: orderedMenuItems)
            }
        }
        
        return orders
    }
    
    /*
    func fetchData2() -> String {
        var message = "works?"
        
        
        db.collection("orders").getDocuments() { (querySnapshot, err) in
            if let err = err {
                message = "Error getting documents: \(err)"
            } else {
                for document in querySnapshot!.documents {
                    message += "\(document.documentID) => \(document.data())"
                }
                message = "nothing"
            }
        }
        
        return message
    }
    */
    
    
    func addOrder(order: OrderModel) -> String {
        let docRef = db.collection("orders").document(order.id!)
        
        if order.tableNumber == 0 {
            return "Invalid table number"
        }
        
        do {
            try docRef.setData(from: order)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }

}

class MenuRepository: ObservableObject {
    
    
}
