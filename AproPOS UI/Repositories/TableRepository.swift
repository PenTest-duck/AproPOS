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

class TableRepository: ObservableObject {
    
    // Create a reference to the Firestore database, and array of tables
    private let db = Firestore.firestore()
    var tables = [TableModel]()

    // Retrieve table data from Firestore and return an array of all tables
    func fetchTables(completion: @escaping ([TableModel]) -> Void) {
        db.collection("tables").addSnapshotListener { (querySnapshot, error) in // Asynchronous update automatically when values change
            // Error handling when there are no documents in the collection
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            // Map retrieved data to an array of individual TableModels
            self.tables = documents.map { queryDocumentSnapshot -> TableModel in
                let data = queryDocumentSnapshot.data()
                
                // Extract values in data to variables
                let id = queryDocumentSnapshot.documentID
                let seats = data["seats"] as? Int ?? 0
                let status = data["status"] as? String ?? "free"

                // Add constructed TableModel to tables
                return TableModel(id: id, seats: seats, status: status)
            }
        
            // Return the tables when Firebase requests complete
            print(self.tables)
            completion(self.tables)
        }
    }
    
    // Add a new table to the database
    func addTable(table: TableModel) {
        let docRef = db.collection("tables").document(table.id!)
        
        do {
            try docRef.setData(from: table)
            print("success")
        } catch { // Error handling
            print(error.localizedDescription)
        }
    }

    // Remove an existing table from the database
    func removeTable(tableNumber: String) {
        OrderRepository().removeOrder(tableNumber: tableNumber)
        
        db.collection("tables").document(tableNumber).delete() { err in
            // Error handling
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
