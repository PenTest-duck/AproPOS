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
import UIKit

class OrderRepository: ObservableObject {
    // From: https://peterfriese.dev/posts/swiftui-firebase-fetch-data/
    private let db = Firestore.firestore()
    var orders = [OrderModel]()
    var menuPrices = [[String: Decimal]]()
    var menuIngredients = [[String: [String: Int]]]()
    var subtotalPrice = Decimal(0)

    func fetchOrders(completion: @escaping ([OrderModel]) -> Void) {
        db.collection("orders").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.orders = documents.map { queryDocumentSnapshot -> OrderModel in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                let orderTime = (data["orderTime"] as? Timestamp)?.dateValue() ?? Date()
                let status = data["status"] as? String ?? ""
                let menuItems = data["menuItems"] as? [[String: Any]] ?? []
                let subtotalPrice = data["subtotalPrice"] as? Double ?? 0.00
                
                let convertedMenuItems = self.convertMenuItems(menuItems: menuItems)

                return OrderModel(id: id, orderTime: orderTime, status: status, menuItems: convertedMenuItems, subtotalPrice: Decimal(subtotalPrice))
            }
            
            print(self.orders)
            completion(self.orders)
        }
    }
    
    //func addOrder(id: String, menuItems: [OrderedMenuItem]) {
    func addOrder(order: OrderModel) {
        var existingTables: [String] = []
        
        self.db.collection("tables").getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                
            existingTables = documents.map { queryDocumentSnapshot -> String in
                return queryDocumentSnapshot.documentID
            }
            
            if existingTables.contains(order.id!) {
                
                // Add Order:
                let docRef = self.db.collection("orders").document(order.id!)
                
                do {
                    try docRef.setData(from: order)
                    print("success")
                } catch {
                    print(error.localizedDescription)
                }
                
                self.db.collection("tables").document(order.id!).updateData(["status": "ordered"])
            } else {
                print("Table doesn't exist")
            }
        }
    }
    
    func reduceInventory(menuItems: [OrderedMenuItem], completion: @escaping (String) -> Void) {
        db.collection("menu").getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.menuIngredients = documents.map { queryDocumentSnapshot -> [String: [String: Int]] in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let ingredients = data["ingredients"] as? [String: Int] ?? [:]
                return [id: ingredients]
            }
                        
            for menuItem in menuItems {
                let ingredients = (self.menuIngredients.compactMap { $0[menuItem.name] })[0]
                for ingredient in ingredients {
                    self.db.collection("inventory").document(ingredient.key).getDocument { (document, error) in
                        guard let document = document, document.exists else {
                            print("No documents")
                            return
                        }
                        
                        let data = document.data()
                        let currentStock = data!["currentStock"] as? Double ?? 0.0
                        
                        /*print("====")
                        print(menuItem)
                        print(currentStock)
                        print(Decimal(ingredient.value * menuItem.quantity))
                        print("====")*/
                        
                        if Decimal(currentStock) < Decimal(ingredient.value * menuItem.quantity) {
                            completion(ingredient.key)
                        } else {
                            self.db.collection("inventory").document(ingredient.key).updateData(["currentStock": FieldValue.increment(-Double(ingredient.value * menuItem.quantity))])
                        }
                    }
                }
            }
            completion("success")
        }
    }
    

    func editOrder(id: String, newMenuItems: [String: Int]) {
        // TODO: Edit order with checking availability
        
    }
    
    func removeOrder(tableNumber: String) { // TODO: ingredients should be replaced?
        db.collection("orders").document(tableNumber).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func changeOrderStatus(tableNumber: String, status: String) {
        db.collection("orders").document(tableNumber).updateData(["status": status]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated!")
            }
        }
    }
    
    func convertMenuItems(menuItems: [[String: Any]]) -> [OrderedMenuItem] {
        var convertedMenuItems: [OrderedMenuItem] = []
        for menuItem in menuItems {
            let menuItemName = menuItem["name"] as? String ?? ""
            let menuItemQuantity = menuItem["quantity"] as? Int ?? 0
            let menuItemPrice = menuItem["price"] as? Double ?? 0.00
            let menuItemServed = menuItem["served"] as? Bool ?? false
            
            let convertedMenuItem = OrderedMenuItem(name: menuItemName, quantity: menuItemQuantity, price: Decimal(menuItemPrice), served: menuItemServed)
            convertedMenuItems.append(convertedMenuItem)
        }
        
        return convertedMenuItems
    }
    
    func toggleMenuItemServed(tableNumber: String, menuItems: [OrderedMenuItem], name: String, completion: @escaping (_ success: Bool) -> Void) {
        let oldMenuItem = menuItems.first(where: { $0.name == name } )!
        let newMenuItem = OrderedMenuItem(name: oldMenuItem.name, quantity: oldMenuItem.quantity, price: oldMenuItem.price, served: !oldMenuItem.served)
        
        let encodedOldMenuItem = try! Firestore.Encoder().encode(oldMenuItem)
        let encodedNewMenuItem = try! Firestore.Encoder().encode(newMenuItem)
        
        db.collection("orders").document(tableNumber).updateData([ "menuItems" : FieldValue.arrayRemove([encodedOldMenuItem]) ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                //print("Document successfully updated!")
            }
        }
        
        db.collection("orders").document(tableNumber).updateData([ "menuItems" : FieldValue.arrayUnion([encodedNewMenuItem]) ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                //print("Document successfully updated!")
            }
        }
        
        completion(true)
    }
}
