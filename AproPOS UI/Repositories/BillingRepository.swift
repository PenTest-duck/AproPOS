//
//  BillingRepository.swift
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

class BillingRepository: ObservableObject {
    
    // Create a reference to the Firestore database, and an array of bills
    private let db = Firestore.firestore()
    var billsHistory = [BillingModel]()
    
    // Retrieve bills data from Firestore and return an array of all bills
    func fetchBills(completion: @escaping ([BillingModel]) -> Void) {
        db.collection("billsHistory").addSnapshotListener { (querySnapshot, error) in // Asynchronous update automatically when values change
            // Error handling when there are no documents in the collection
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            // Map retrieved data to an array of individual BillingModels
            self.billsHistory = documents.map { queryDocumentSnapshot -> BillingModel in
                let data = queryDocumentSnapshot.data()
                
                // Extract values in data to variables
                let id = queryDocumentSnapshot.documentID
                let tableNumber = data["tableNumber"] as? String ?? ""
                let order = data["order"] as? [String: Any] ?? [:]
                let discount = data["discount"] as? Double ?? 0.00
                let totalPrice = data["totalPrice"] as? Double ?? 0.00
                let billingTime = (data["billingTime"] as? Timestamp)?.dateValue() ?? Date()
                let server = data["server"] as? String ?? ""
                
                // Extract values within the order element of BillingModel to variables
                let orderOrderTime = (order["orderTime"] as? Timestamp)?.dateValue() ?? Date()
                let orderStatus = order["status"] as? String ?? ""
                let orderMenuItems = order["menuItems"] as? [[String: Any]] ?? []
                let orderSubtotalPrice = order["subtotalPrice"] as? Double ?? 0.00
                let orderEstimatedServingTime = order["estimatedServingTime"] as? Int ?? 0
                
                // Convert menuItems array to array of OrderedMenuItems
                let convertedOrderMenuItems = self.convertMenuItems(menuItems: orderMenuItems)
                
                // Create an OrderModel with all extracted data
                let convertedOrder = OrderModel(id: tableNumber, orderTime: orderOrderTime, status: orderStatus, menuItems: convertedOrderMenuItems, subtotalPrice: Decimal(orderSubtotalPrice), estimatedServingTime: orderEstimatedServingTime)
                
                // Add constructed BillingModels to billsHistory
                return BillingModel(id: id, tableNumber: tableNumber, order: convertedOrder, discount: Decimal(discount), totalPrice: Decimal(totalPrice), billingTime: billingTime, server: server)
                
            }
            
            // Return the bills when Firebase requests complete
            print(self.billsHistory)
            completion(self.billsHistory)
        }
    }
    
    // Saves an order to a bill, calculates the total price, and changes the table status
    func processBill(tableNumber: String, discount: Decimal, server: String) { 
        db.collection("orders").document(tableNumber).getDocument { (document, error) in // Get all order documents once (not synchronised)
            // Error handling when there are no documents in the collection
            guard let document = document, document.exists else {
                print("No documents")
                return
            }
            
            // Extract data fields from order
            let data = document.data()
            let orderTime = (data!["orderTime"] as? Timestamp)?.dateValue() ?? Date()
            let status = data!["status"] as? String ?? ""
            let menuItems = data!["menuItems"] as? [[String: Any]] ?? []
            let subtotalPrice = data!["subtotalPrice"] as? Double ?? 0.00
            let estimatedServingTime = data!["estimatedServingTime"] as? Int ?? 0
            
            // Convert menuItems array to array of OrderedMenuItems
            let convertedMenuItems = self.convertMenuItems(menuItems: menuItems)
            
            // Create a new OrderModel with all extracted data
            let order = OrderModel(id: tableNumber, orderTime: orderTime, status: status, menuItems: convertedMenuItems, subtotalPrice: Decimal(subtotalPrice), estimatedServingTime: estimatedServingTime)
        
            // Calculate total price
            let totalPrice = order.subtotalPrice - discount
            
            // Create a new BillingModel with updated data
            let newBill = BillingModel(tableNumber: tableNumber, order: order, discount: discount, totalPrice: totalPrice, server: server)
            
            // Add bill to the database, in the billsHistory collection
            let docRef = self.db.collection("billsHistory").document(newBill.id!)
            do {
                try docRef.setData(from: newBill)
                print("success")
            } catch { // Error handling
                print(error.localizedDescription)
            }
            
            // Remove original order in the order collection
            self.removeOrder(tableNumber: tableNumber)
            
            // Update the table status
            var existingTables: [String] = []
            self.db.collection("tables").getDocuments() { (querySnapshot, error) in // Get all table documents once (not synchronised)
                // Error handling when there are no documents in the collection
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                // Create an array of IDs (table numbers) of existing tables
                existingTables = documents.map { queryDocumentSnapshot -> String in
                    return queryDocumentSnapshot.documentID
                }
                
                // TODO: Change status to... cleaning?
                if existingTables.contains(tableNumber) {
                    self.db.collection("tables").document(tableNumber).updateData(["status": "cleaning"])
                } else {
                    print("Error: table doesn't exist")
                }
            }
        }
    }
    
    // Remove an existing order from the database
    func removeOrder(tableNumber: String) { // TODO: ingredients should be replaced?
        db.collection("orders").document(tableNumber).delete() { err in
            // Error handling
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
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
}
