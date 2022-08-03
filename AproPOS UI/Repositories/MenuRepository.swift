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
    
    // Create references to Firestore and Firebase Storage
    private let db = Firestore.firestore()
    private let storageRef = Storage.storage().reference() // TODO: remove
    
    var menu = [MenuItemModel]()
    var ingredientStock = [[String: Double]]()
    
    // Retrieve menu item data from Firestore and return an array of all menu items
    func fetchMenu(completion: @escaping ([MenuItemModel]) -> Void) { 
        db.collection("menu").addSnapshotListener { (querySnapshot, error) in // Asynchronous update automatically when values change
            // Error handling when there are no documents in the collection
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            // Map retrieved data to an array of individual MenuItemModels
            self.menu = documents.map { queryDocumentSnapshot -> MenuItemModel in
                let data = queryDocumentSnapshot.data()
                
                // Extract values in data to variables
                let id = queryDocumentSnapshot.documentID
                let price = data["price"] as? Double ?? 0.00
                let estimatedServingTime = data["estimatedServingTime"] as? Int ?? 0
                let warnings = data["warnings"] as? [String] ?? []
                let ingredients = data["ingredients"] as? [String: Double] ?? [:]
                let image = data["image"] as? Data ?? (UIImage(named: "defaultMenuItemImage")!).pngData()!
                let status = data["status"] as? [String: [String]] ?? ["available": []]
                
                // Convert the image from Data to UIImage
                let deserialisedImage = UIImage(data: image)!
                
                // Convert each value of the ingredients array to Decimal
                var convertedIngredients: [String: Decimal] = [:]
                for ingredient in ingredients {
                    convertedIngredients[ingredient.key] = Decimal(ingredient.value)
                }
                
                // Add constructed MenuItemModel to menu
                return MenuItemModel(id: id, price: Decimal(price), estimatedServingTime: estimatedServingTime, warnings: warnings, ingredients: convertedIngredients, image: deserialisedImage, status: status)
            }
            
            // Return the menu items when Firebase requests complete
            print(self.menu)
            completion(self.menu)
        }
    }
    
    // Add a new menu item to the database
    func addMenuItem(menuItem: MenuItemModel) {
        let docRef = db.collection("menu").document(menuItem.id!)
        
        do {
            try docRef.setData(from: menuItem)
            print("success")
        } catch { // Error handling
            print(error.localizedDescription)
        }
        
        // TODO: remove
        let imageRef = storageRef.child("images").child(menuItem.id!)
        imageRef.putData(menuItem.image, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print("Error uploading to storage")
                return
            }
        }
    }
    
    // Monitor inventory stock levels for each menu item, and adjust status accordingly
    func checkUnavailableMenuItems() {
        db.collection("inventory").addSnapshotListener { (querySnapshot, error) in // Asynchronous update automatically when inventory values change
            // Error handling when there are no documents in the collection
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            // Map retrieved ingredient data to a dictionary of [id: currentStock]
            self.ingredientStock = documents.map { queryDocumentSnapshot -> [String: Double] in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let currentStock = data["currentStock"] as? Double ?? 0
                return [id: currentStock]
            }
            
            for menuItem in self.menu {
                var lowIngredients = menuItem.status["unavailable"] ?? [] // Extract the array of low ingredients; should be [] for "available"
                
                // When the menu item is available but may be changed to unavailable
                // Checks stock levels of each ingredient in menu item
                if Array(menuItem.status.keys)[0] == "available" { // Checking the key of the nested dictionary
                    for ingredient in menuItem.ingredients {
                        var stock: Double = 0
                        let ingStock = self.ingredientStock.compactMap({ $0[ingredient.key] }) // Extracts relevant ingredient stock
                        
                        if ingStock != [] {
                            stock = ingStock[0]
                        }
                        
                        // If stock levels are too low, add to lowIngredients and update the database
                        if Decimal(stock) < ingredient.value {
                            lowIngredients.append(ingredient.key)
                            self.db.collection("menu").document(menuItem.id!).updateData(["status": ["unavailable": lowIngredients]])
                        }
                    }
                    
                // When the menu item is unavailable but may be changed to available
                // Checks stock levels of each low ingredient
                } else {
                    for ingredient in lowIngredients {
                        var stock: Double = 0
                        let ingStock = self.ingredientStock.compactMap({ $0[ingredient] }) // Extracts relevant ingredient stock
                        
                        if ingStock != [] {
                            stock = ingStock[0]
                        }
                        
                        // If stock levels are sufficient, remove from low ingredients and update the database
                        if Decimal(stock) >= (menuItem.ingredients[ingredient] ?? Decimal(stock - 1)) {
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
    
    // Remove an existing menu item from the database
    func removeMenuItem(name: String) {
        db.collection("menu").document(name).delete() { err in
            // Error handling
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    // TODO: remove
    func fetchImage(id: String, completion: @escaping (UIImage) -> Void) {
        let imageRef = self.storageRef.child("images/\(id)")
        
        var image = UIImage(named: "defaultMenuItemImage")!
        imageRef.getData(maxSize: 50 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error getting image from Firebase Storage: \(error.localizedDescription)")
            } else {
                image = UIImage(data: data!)!
            }
            
            completion(image)
        }
    }
}
