//
//  InventoryRepository.swift
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

class InventoryRepository: ObservableObject {
    
    // Create a reference to the Firestore database, and array of inventory items
    private let db = Firestore.firestore()
    var inventory = [IngredientModel]()
    
    // Retrieve inventory item data from Firestore and return an array of all inventory items
    func fetchInventory(completion: @escaping ([IngredientModel]) -> Void) {
        db.collection("inventory").addSnapshotListener { (querySnapshot, error) in // Asynchronous update automatically when values change
            // Error handling when there are no documents in the collection
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            // Map retrieved data to an array of individual InventoryModels
            self.inventory = documents.map { queryDocumentSnapshot -> IngredientModel in
                let data = queryDocumentSnapshot.data()
        
                // Extract values in data to variables
                let id = queryDocumentSnapshot.documentID
                let units = data["units"] as? String ?? ""
                let currentStock = data["currentStock"] as? Double ?? 0
                let minimumThreshold = data["minimumThreshold"] as? Double ?? 0
                let costPerUnit = data["costPerUnit"] as? Double ?? 0.00
                let warnings = data["warnings"] as? [String] ?? []
                let comment = data["comment"] as? String ?? ""
                let status = data["status"] as? String ?? "available"

                // Add constructed TableModel to tables
                return IngredientModel(id: id, units: units, currentStock: Decimal(currentStock), minimumThreshold: Decimal(minimumThreshold), costPerUnit: Decimal(costPerUnit), warnings: warnings, comment: comment, status: status)
            }
            
            // Monitor inventory values and change inventory item statuses accordingly
            self.monitorInventory()
            
            // Return the tables when Firebase requests complete
            print(self.inventory)
            completion(self.inventory)
        }
    }
    
    // Checks the stock levels of all items in the inventory, and adjusts statuses accordingly
    func monitorInventory() {
        for ingredient in self.inventory {
            var currentStatus: String
            
            if ingredient.currentStock <= 0 { // Check currentStock is 0
                currentStatus = "unavailable"
            } else if ingredient.currentStock < ingredient.minimumThreshold { // Check currentStock is less than the minimumThreshold
                currentStatus = "low"
            } else { // Check currentStock greater than or equal to the minimumThreshold
                currentStatus = "available"
            }
            
            // If status has been changed, update database
            if currentStatus != ingredient.status {
                db.collection("inventory").document(ingredient.id!).updateData(["status": currentStatus])
            }
        }
    }
    
    // Add a new ingredient to the database
    func addIngredient(ingredient: IngredientModel) {
        let docRef = db.collection("inventory").document(ingredient.id!)
        
        do {
            try docRef.setData(from: ingredient)
            print("success")
        } catch { // Error handling
            print(error.localizedDescription)
        }
    }
    
    // Remove an existing inventory item from the database
    func removeIngredient(name: String) {
        db.collection("inventory").document(name).delete() { err in
            // Error handling
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
