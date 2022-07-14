//
//  TableRepository.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 5/7/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import UIKit

class TableRepository: ObservableObject { // for the table view and status etc
    
    private let db = Firestore.firestore() // get the db
    var tables = [TableModel]()  // referring to the table model file

    func fetchTables(completion: @escaping ([TableModel]) -> Void) { // gets info from table models
        db.collection("tables").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.tables = documents.map { queryDocumentSnapshot -> TableModel in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                let seats = data["seats"] as? Int ?? 0
                let status = data["status"] as? String ?? "free"

                return TableModel(id: id, seats: seats, status: status)
            }
        
            print(self.tables)
            completion(self.tables)
        }
    }
    
    func addTable(table: TableModel) {
        let docRef = db.collection("tables").document(table.id!)
        
        do {
            try docRef.setData(from: table)
            print("success")
        } catch {
            print(error.localizedDescription)
        }
    }

    func removeTable(tableNumber: String) {
        OrderRepository().removeOrder(tableNumber: tableNumber)
        
        db.collection("tables").document(tableNumber).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
