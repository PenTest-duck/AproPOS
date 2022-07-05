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
    
    private let db = Firestore.firestore()
    var billsHistory = [BillingModel]()
    
    func processBill(tableNumber: String, discount: Decimal, server: String) {
        db.collection("orders").document(tableNumber).getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("No documents")
                return
            }

            let data = document.data()
            let orderTime = (data!["orderTime"] as? Timestamp)?.dateValue() ?? Date()
            let status = data!["status"] as? String ?? ""
            let menuItems = data!["menuItems"] as? [[String: Any]] ?? []
            let subtotalPrice = data!["subtotalPrice"] as? Double ?? 0.00
            
            let convertedMenuItems = self.convertMenuItems(menuItems: menuItems)
            let order = OrderModel(id: tableNumber, orderTime: orderTime, status: status, menuItems: convertedMenuItems, subtotalPrice: Decimal(subtotalPrice))
        
            let totalPrice = order.subtotalPrice - discount
            
            let newBill = BillingModel(tableNumber: tableNumber, order: order, discount: discount, totalPrice: totalPrice, server: server)
            let docRef = self.db.collection("billsHistory").document(newBill.id!)
            
            do {
                try docRef.setData(from: newBill)
                print("success")
            } catch {
                print(error.localizedDescription)
            }
            
            self.removeOrder(tableNumber: tableNumber)
            
            // Change table status:
            var existingTables: [String] = []
            self.db.collection("tables").getDocuments() { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                    
                existingTables = documents.map { queryDocumentSnapshot -> String in
                    return queryDocumentSnapshot.documentID
                }
                
                if existingTables.contains(tableNumber) {
                    self.db.collection("tables").document(tableNumber).updateData(["status": "cleaning"])
                } else {
                    print("Table doesn't exist")
                }
            }
        }
    }
    
    func fetchBills(completion: @escaping ([BillingModel]) -> Void) {
        db.collection("billsHistory").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.billsHistory = documents.map { queryDocumentSnapshot -> BillingModel in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let tableNumber = data["tableNumber"] as? String ?? ""
                let order = data["order"] as? [String: Any] ?? [:]
                let discount = data["discount"] as? Double ?? 0.00
                let totalPrice = data["totalPrice"] as? Double ?? 0.00
                let billingTime = (data["billingTime"] as? Timestamp)?.dateValue() ?? Date()
                let server = data["server"] as? String ?? ""
                
                let orderOrderTime = (order["orderTime"] as? Timestamp)?.dateValue() ?? Date()
                let orderStatus = order["status"] as? String ?? ""
                let orderMenuItems = order["menuItems"] as? [[String: Any]] ?? []
                let orderSubtotalPrice = order["subtotalPrice"] as? Double ?? 0.00
                
                let convertedOrderMenuItems = self.convertMenuItems(menuItems: orderMenuItems)
                
                let convertedOrder = OrderModel(id: tableNumber, orderTime: orderOrderTime, status: orderStatus, menuItems: convertedOrderMenuItems, subtotalPrice: Decimal(orderSubtotalPrice))
                
                return BillingModel(id: id, tableNumber: tableNumber, order: convertedOrder, discount: Decimal(discount), totalPrice: Decimal(totalPrice), billingTime: billingTime, server: server)
                
            }
            
            print(self.billsHistory)
            completion(self.billsHistory)
        }
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
    
    func convertMenuItems(menuItems: [[String: Any]]) -> [OrderedMenuItem] {
        var convertedMenuItems: [OrderedMenuItem] = []
        for menuItem in menuItems {
            let menuItemName = menuItem["name"] as? String ?? ""
            let menuItemQuantity = menuItem["quantity"] as? Int ?? 0
            let menuItemPrice = menuItem["price"] as? Double ?? 0.00
            
            let convertedMenuItem = OrderedMenuItem(name: menuItemName, quantity: menuItemQuantity, price: Decimal(menuItemPrice))
            convertedMenuItems.append(convertedMenuItem)
        }
        
        return convertedMenuItems
    }
}
