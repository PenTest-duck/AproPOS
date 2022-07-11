//
//  MenuRepository.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 5/7/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import Combine
import UIKit

class MenuRepository: ObservableObject {
    
    private let db = Firestore.firestore()
    private let storageRef = Storage.storage().reference()
    
    var menu = [MenuItemModel]()
    var ingredientStock = [[String: Double]]()
    
    func fetchMenu(completion: @escaping ([MenuItemModel]) -> Void) {
        db.collection("menu").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.menu = documents.map { queryDocumentSnapshot -> MenuItemModel in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                let price = data["price"] as? Double ?? 0.00
                let estimatedServingTime = data["estimatedServingTime"] as? Int ?? 0
                let warnings = data["warnings"] as? [String] ?? []
                let ingredients = data["ingredients"] as? [String: Double] ?? [:]
                let image = data["image"] as? Data ?? (UIImage(named: "defaultMenuItemImage")!).pngData()!
                let status = data["status"] as? [String: [String]] ?? ["available": []]
                
                let deserialisedImage = UIImage(data: image)!
                var convertedIngredients: [String: Decimal] = [:]
                for ingredient in ingredients {
                    convertedIngredients[ingredient.key] = Decimal(ingredient.value)
                }

                return MenuItemModel(id: id, price: Decimal(price), estimatedServingTime: estimatedServingTime, warnings: warnings, ingredients: convertedIngredients, image: deserialisedImage, status: status)
            }
            
            print(self.menu)
            completion(self.menu)
        }
    }
    
    func addMenuItem(menuItem: MenuItemModel) {
        let docRef = db.collection("menu").document(menuItem.id!)
        
        do {
            try docRef.setData(from: menuItem)
            print("success")
        } catch {
            print(error.localizedDescription)
        }
        /*
        let imageRef = storageRef.child("images").child(menuItem.id!)
        imageRef.putData(menuItem.image, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print("Error uploading to storage")
                return
            }
            
            print(metadata)
        }*/
    }
    
    func editMenuItem(name: String) {
        
    }
    
    func checkUnavailableMenuItems() {
        db.collection("inventory").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.ingredientStock = documents.map { queryDocumentSnapshot -> [String: Double] in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let currentStock = data["currentStock"] as? Double ?? 0
                return [id: currentStock]
            }
            
            for menuItem in self.menu {
                var lowIngredients = menuItem.status["unavailable"] ?? [] // hopefully should be [] for "available"
                if Array(menuItem.status.keys)[0] == "available" {
                    for ingredient in menuItem.ingredients {
                        let stock = (self.ingredientStock.compactMap { $0[ingredient.key] })[0]
                        if Decimal(stock) < ingredient.value {
                            lowIngredients.append(ingredient.key)
                            self.db.collection("menu").document(menuItem.id!).updateData(["status": ["unavailable": lowIngredients]])
                        }
                    }
                } else {
                    for ingredient in lowIngredients {
                        let stock = (self.ingredientStock.compactMap { $0[ingredient] })[0]
                        if Decimal(stock) >= menuItem.ingredients[ingredient]! {
                            lowIngredients.removeAll(where: { $0 == ingredient })
                            if lowIngredients.isEmpty {
                                self.db.collection("menu").document(menuItem.id!).updateData(["status": ["available": lowIngredients]])
                            } else {
                                self.db.collection("menu").document(menuItem.id!).updateData(["status": ["unavailable": lowIngredients]])
                            }
                        }
                    }
                }
            }
        }
    }
    
    func removeMenuItem(name: String) {
        db.collection("menu").document(name).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
