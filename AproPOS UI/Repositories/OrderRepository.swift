//
//  OrderRepository.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 5/7/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
//import UIKit

class OrderRepository: ObservableObject {
    
    // Create a reference to the Firestore database, and an array of orders
    private let db = Firestore.firestore()
    var orders = [OrderModel]()
    
    // Declare menuIngredients as an array of dictionaries
    var menuIngredients = [[String: [String: Int]]]()

    // Retrieve orders data from Firestore and return an array of all orders
    func fetchOrders(completion: @escaping ([OrderModel]) -> Void) {
        db.collection("orders").addSnapshotListener { (querySnapshot, error) in // Asynchronous update automatically when values change
            // Error handling when there are no documents in the collection
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            // Map retrieved data to an array of individual OrderModels
            self.orders = documents.map { queryDocumentSnapshot -> OrderModel in
                let data = queryDocumentSnapshot.data()
                
                // Extract values in data to variables
                let id = queryDocumentSnapshot.documentID
                let orderTime = (data["orderTime"] as? Timestamp)?.dateValue() ?? Date()
                let status = data["status"] as? String ?? ""
                let menuItems = data["menuItems"] as? [[String: Any]] ?? []
                let subtotalPrice = data["subtotalPrice"] as? Double ?? 0.00
                let estimatedServingTime = data["estimatedServingTime"] as? Int ?? 0
                
                // Convert menuItems array to array of OrderedMenuItems
                let convertedMenuItems = self.convertMenuItems(menuItems: menuItems)

                // Add constructed OrderModels to orders
                return OrderModel(id: id, orderTime: orderTime, status: status, menuItems: convertedMenuItems, subtotalPrice: Decimal(subtotalPrice), estimatedServingTime: estimatedServingTime)
            }
            
            // Return the orders when Firebase requests complete
            print(self.orders)
            completion(self.orders)
        }
    }
    
    // Add a new order to the database
    func addOrder(order: OrderModel) {
        let docRef = self.db.collection("orders").document(order.id!)
        
        do {
            try docRef.setData(from: order)
            print("success")
        } catch { // Error handling
            print(error.localizedDescription)
        }
        
        // Update table status to "ordered"
        self.db.collection("tables").document(order.id!).updateData(["status": "ordered"])
    }
    
    // Reduce inventory stock levels according to menu items ordered
    func reduceInventory(menuItems: [OrderedMenuItem], completion: @escaping (String) -> Void) {
        db.collection("menu").getDocuments() { (querySnapshot, error) in // Get all menu documents once (not synchronised)
            // Error handling when there are no documents in the collection
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            // Map retrieved menu data to a dictionary of [id: ingredients]
            self.menuIngredients = documents.map { queryDocumentSnapshot -> [String: [String: Int]] in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let ingredients = data["ingredients"] as? [String: Int] ?? [:]
                return [id: ingredients]
            }
                  
            // Iterate through each menu item and reduce inventory for its ingredients
            for menuItem in menuItems {
                let ingredients = (self.menuIngredients.compactMap { $0[menuItem.name] })[0] // Extracts relevant menu item
                
                // Iterate through each ingredient and reduce inventory
                for ingredient in ingredients {
                    self.db.collection("inventory").document(ingredient.key).getDocument { (document, error) in // Get all inventory documents once (not synchronised)
                        // Error handling when there are no documents in the collection
                        guard let document = document, document.exists else {
                            print("No documents")
                            return
                        }
                        
                        // Extract the current stock
                        let data = document.data()
                        let currentStock = data!["currentStock"] as? Double ?? 0.0
                        
                        // Check if enough stock exists
                        if Decimal(currentStock) < Decimal(ingredient.value * menuItem.quantity) {
                            // If not enough stock exists, return the name of low ingredient
                            completion(ingredient.key)
                        } else {
                            // If enough stock exists, update the database by decreasing stock levels
                            self.db.collection("inventory").document(ingredient.key).updateData(["currentStock": FieldValue.increment(-Double(ingredient.value * menuItem.quantity))])
                        }
                    }
                }
            }
            completion("success") // Only runs if there is enough stock for all ingredients of all menu items
        }
    }
    

    func editOrder(id: String, newMenuItems: [String: Int]) {
        // TODO: Edit order with checking availability
        
    }
    
    // Remove an existing order from the database
    func removeOrder(tableNumber: String) { // TODO: ingredients should be replaced? ... probably not
        db.collection("orders").document(tableNumber).delete() { err in
            // Error handling
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    // Change the status of an existing order
    func changeOrderStatus(tableNumber: String, status: String) {
        db.collection("orders").document(tableNumber).updateData(["status": status]) { err in
            // Error handling
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated!")
            }
        }
    }
    
    // Converts an array of dictionaries to an array of OrderedMenuItems
    func convertMenuItems(menuItems: [[String: Any]]) -> [OrderedMenuItem] {
        var convertedMenuItems: [OrderedMenuItem] = []
        for menuItem in menuItems {
            // Extract each menu item dictionary to variables
            let menuItemName = menuItem["name"] as? String ?? ""
            let menuItemQuantity = menuItem["quantity"] as? Int ?? 0
            let menuItemPrice = menuItem["price"] as? Double ?? 0.00
            let menuItemServed = menuItem["served"] as? Bool ?? false
            
            // Create an OrderedMenuItem and append to the output array
            let convertedMenuItem = OrderedMenuItem(name: menuItemName, quantity: menuItemQuantity, price: Decimal(menuItemPrice), served: menuItemServed)
            convertedMenuItems.append(convertedMenuItem)
        }
        
        return convertedMenuItems
    }
    
    // Toggle the "served" value of a menu item
    func toggleMenuItemServed(tableNumber: String, menuItems: [OrderedMenuItem], name: String, completion: @escaping (_ success: Bool) -> Void) {
        // Extract data from existing menu item and create a new menu item with same data but toggled "served" value
        let oldMenuItem = menuItems.first(where: { $0.name == name } )!
        let newMenuItem = OrderedMenuItem(name: oldMenuItem.name, quantity: oldMenuItem.quantity, price: oldMenuItem.price, served: !oldMenuItem.served)
        
        // Encodes both OrderedMenuItems, as Firebase cannot seem to handle struct data
        let encodedOldMenuItem = try! Firestore.Encoder().encode(oldMenuItem)
        let encodedNewMenuItem = try! Firestore.Encoder().encode(newMenuItem)
        
        // Remove the existing menu item from the order's menuItems array on the database
        db.collection("orders").document(tableNumber).updateData([ "menuItems" : FieldValue.arrayRemove([encodedOldMenuItem]) ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
        }
        
        // Add the toggled menu item to the order's menuItems array on the database
        db.collection("orders").document(tableNumber).updateData([ "menuItems" : FieldValue.arrayUnion([encodedNewMenuItem]) ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
        }
        
        // Need to return success as true for completion closure
        completion(true)
    }
}
