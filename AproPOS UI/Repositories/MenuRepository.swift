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
import Combine
import UIKit

class MenuRepository: ObservableObject {
    
    private let db = Firestore.firestore()
    var menu = [MenuItemModel]()
    var ingredientStock = [[String: Double]]()
    
    func fetchMenu() -> [MenuItemModel] {
        db.collection("menu").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.menu = documents.map { queryDocumentSnapshot -> MenuItemModel in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                //let price = data["price"] as? Decimal ?? 0.00
                let price = data["price"] as? Double ?? 0.00
                let estimatedServingTime = data["estimatedServingTime"] as? Int ?? 0
                let warnings = data["warnings"] as? [String] ?? []
                let ingredients = data["ingredients"] as? [String: Int] ?? [:]
                let image = data["image"] as? Data ?? (UIImage(named: "defaultMenuItemImage")!).pngData()!
                let status = data["status"] as? [String: [String]] ?? ["available": []]
                
                let deserialisedImage = UIImage(data: image)!

                return MenuItemModel(id: id, price: Decimal(price), estimatedServingTime: estimatedServingTime, warnings: warnings, ingredients: ingredients, image: deserialisedImage, status: status)
            }
        }
        
        return menu
    }
    
    func addMenuItem(menuItem: MenuItemModel) -> String {
        let docRef = db.collection("menu").document(menuItem.id!)
        
        do {
            try docRef.setData(from: menuItem)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }
    
    func editMenuItem(name: String) {
        
    }
    
    func checkUnavailableMenuItems() {
        let menu = fetchMenu() // should refresh menu?
        
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
            
            for menuItem in menu {
                var lowIngredients = menuItem.status["unavailable"] ?? [] // hopefully should be [] for "available"
                if Array(menuItem.status.keys)[0] == "available" {
                    for ingredient in menuItem.ingredients {
                        let stock = (self.ingredientStock.compactMap { $0[ingredient.key] })[0]
                        if stock < Double(ingredient.value) {
                            lowIngredients.append(ingredient.key)
                            self.db.collection("menu").document(menuItem.id!).updateData(["status": ["unavailable": lowIngredients]])
                        }
                    }
                } else {
                    for ingredient in lowIngredients {
                        let stock = (self.ingredientStock.compactMap { $0[ingredient] })[0]
                        if stock >= Double(menuItem.ingredients[ingredient]!) {
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
        db.collection("menu").document(name).delete() { err in // function doesn't throw?
            if let err = err {
                //return err
                print("Error removing document: \(err)")
            } else {
                //return "success"
                print("Document successfully removed!")
            }
        }
    }
}
