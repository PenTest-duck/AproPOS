//
//  Repository.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import UIKit // for UIImage


class UserRepository: ObservableObject {
    //@Published var createAccountSuccess = false
    //@Published var createAccountError = "" // Contains create account error message
    
    private let db = Firestore.firestore()
    
    func addUser(user: UserModel) -> String {
        let docRef = db.collection("users").document(user.id!)
        
        do {
            try docRef.setData(from: user)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }
}

class OrderRepository: ObservableObject {
    // From: https://peterfriese.dev/posts/swiftui-firebase-fetch-data/
    private let db = Firestore.firestore()
    var orders = [OrderModel]()

    func fetchOrders() -> [OrderModel] {
        db.collection("orders").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.orders = documents.map { queryDocumentSnapshot -> OrderModel in
                let data = queryDocumentSnapshot.data()
                let tableNumber = data["tableNumber"] as? Int ?? 0
                let startTimeEvent = data["startTimeEvent"] as? Date ?? Date() // nil
                let status = data["status"] as? String ?? ""
                let orderedMenuItems = data["orderedMenuItems"] as? [String: Int] ?? [:]

                return OrderModel(tableNumber: tableNumber, startTimeEvent: startTimeEvent, status: status, orderedMenuItems: orderedMenuItems)
            }
        }
        
        return orders
    }
    
    func addOrder(order: OrderModel) -> String {
        let docRef = db.collection("orders").document(order.id!)
        
        if order.tableNumber == 0 {
            return "Invalid table number"
        }
        
        do {
            try docRef.setData(from: order)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }

}

/*
class DataRepository: ObservableObject {
    private let db = Firestore.firestore()
    
    func addItem(category: String, item: AnyObject) -> String {
        
        var orderItem: OrderModel
        
        if category == "orders" {
            orderItem = item as! OrderModel
        }
        
        let docRef = db.collection(category).document(orderItem.id!)
        
        do {
            try docRef.setData(from: orderItem)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }
}
 */

class MenuRepository: ObservableObject {
    
    private let db = Firestore.firestore()
    var menu = [MenuItemModel]()
    
    func fetchMenu() -> [MenuItemModel] {
        db.collection("menu").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.menu = documents.map { queryDocumentSnapshot -> MenuItemModel in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let price = data["price"] as? Decimal ?? 0.00
                let estimatedServingTime = data["estimatedServingTime"] as? Int ?? 0
                let warnings = data["warnings"] as? [String] ?? []
                let ingredients = data["ingredients"] as? [String: Int] ?? [:]
                let image = data["image"] as? Data ?? (UIImage(named: "defaultMenuItemImage")!).pngData()!
                
                let deserialisedImage = UIImage(data: image)!

                return MenuItemModel(id: id, price: price, estimatedServingTime: estimatedServingTime, warnings: warnings, ingredients: ingredients, image: deserialisedImage)
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
    
}

/*
class BillingRepository: ObservableObject {
    
    private let db = Firestore.firestore()
    var bills = [BillingModel]()
    
    func fetchBills() -> [BillingModel] {
        db.collection("bills").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.bills = documents.map { queryDocumentSnapshot -> BillingModel in
                let data = queryDocumentSnapshot.data()
                let orderID = data["orderID"] as? String ?? ""
                let startTimeEvent = data["startTimeEvent"] as? Date ?? Date() // nil
                let subtotalPrice = data["subtotalPrice"] as? Decimal ?? 0.00
                let discount = data["discount"] as? Decimal ?? 0.00
                let totalPrice = data["totalPrice"] as? Decimal ?? 0.00

                return BillingModel(orderID: orderID, startTimeEvent: startTimeEvent, subtotalPrice: subtotalPrice, discount: discount, totalPrice: totalPrice)
            }
        }
        
        return bills
    }
    
    func addBill(bill: BillingModel) -> String {
        let docRef = db.collection("bills").document(bill.id!)
        
        do {
            try docRef.setData(from: bill)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }
    
}
*/
