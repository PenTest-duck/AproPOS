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
    
    private let db = Firestore.firestore()
    var inventory = [IngredientModel]()
    
    func fetchInventory(completion: @escaping ([IngredientModel]) -> Void) {
        db.collection("inventory").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.inventory = documents.map { queryDocumentSnapshot -> IngredientModel in
                let data = queryDocumentSnapshot.data()
        
                let id = queryDocumentSnapshot.documentID
                let units = data["units"] as? String ?? ""
                let currentStock = data["currentStock"] as? Double ?? 0
                let minimumThreshold = data["minimumThreshold"] as? Double ?? 0
                let costPerUnit = data["costPerUnit"] as? Double ?? 0.00
                let warnings = data["warnings"] as? [String] ?? []
                let comment = data["comment"] as? String ?? ""
                let status = data["status"] as? String ?? "available"

                return IngredientModel(id: id, units: units, currentStock: Decimal(currentStock), minimumThreshold: Decimal(minimumThreshold), costPerUnit: Decimal(costPerUnit), warnings: warnings, comment: comment, status: status)
            }
            
            // Monitor inventory status
            self.monitorInventory()
            
            print(self.inventory)
            completion(self.inventory)
        }
    }
    
    func monitorInventory() {
        for ingredient in self.inventory {
            var currentStatus: String
            if ingredient.currentStock <= 0 {
                currentStatus = "unavailable"
            } else if ingredient.currentStock < ingredient.minimumThreshold {
                currentStatus = "low"
            } else {
                currentStatus = "available"
            }
            
            if currentStatus != ingredient.status {
                db.collection("inventory").document(ingredient.id!).updateData(["status": currentStatus])
            }
        }
    }
    
    func addIngredient(ingredient: IngredientModel) {
        let docRef = db.collection("inventory").document(ingredient.id!)
        
        do {
            try docRef.setData(from: ingredient)
            print("success")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editIngredient(name: String) {
        
    }
    
    func removeIngredient(name: String) {
        db.collection("inventory").document(name).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
