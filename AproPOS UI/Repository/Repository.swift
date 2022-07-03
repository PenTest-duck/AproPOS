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
    var menuPrices = [[String: Decimal]]()
    var menuIngredients = [[String: [String: Int]]]()
    var subtotalPrice = Decimal(0)

    func fetchOrders() -> [OrderModel] {
        db.collection("orders").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.orders = documents.map { queryDocumentSnapshot -> OrderModel in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                let startTimeEvent = data["startTimeEvent"] as? Date ?? Date() // nil
                let status = data["status"] as? String ?? ""
                let menuItems = data["menuItems"] as? [String: Int] ?? [:]
                let subtotalPrice = data["subtotalPrice"] as? Double ?? 0.00

                return OrderModel(id: id, startTimeEvent: startTimeEvent, status: status, menuItems: menuItems, subtotalPrice: Decimal(subtotalPrice))
            }
        }
        
        return orders
    }
    
    /*func addOrder2(order: OrderModel) -> String {
        let docRef = db.collection("orders").document(order.id!)
        
        do {
            try docRef.setData(from: order)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }*/
    
    func addOrder(id: String, menuItems: [String: Int]) -> String {
        db.collection("menu").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.menuPrices = documents.map { queryDocumentSnapshot -> [String: Decimal] in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                let price = data["price"] as? Double ?? 0.00

                return [id: Decimal(price)]
            }
            
            for menuItem in menuItems {
                let menuItemPrice = (self.menuPrices.compactMap { $0[menuItem.key] })[0]
                self.subtotalPrice += menuItemPrice * Decimal(menuItem.value)
            }
            
            // Add Order:
            let newOrder = OrderModel(id: id, menuItems: menuItems, subtotalPrice: self.subtotalPrice)
            let docRef = self.db.collection("orders").document(newOrder.id!)
            
            do {
                try docRef.setData(from: newOrder)
                print("success")
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        return "success"
    }
    
    func reduceInventory(menuItems: [String: Int]) {
        db.collection("menu").addSnapshotListener { (querySnapshot, error) in
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
                let ingredients = (self.menuIngredients.compactMap { $0[menuItem.key] })[0]
                for ingredient in ingredients {
                    self.db.collection("inventory").document(ingredient.key).updateData(["currentStock": FieldValue.increment(-Double(ingredient.value * menuItem.value))])
                }
            }
            
        }
    }
    
    func removeOrder(tableNumber: String) {
        db.collection("orders").document(tableNumber).delete() { err in // function doesn't throw?
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
                //let price = data["price"] as? Decimal ?? 0.00
                let price = data["price"] as? Double ?? 0.00
                let estimatedServingTime = data["estimatedServingTime"] as? Int ?? 0
                let warnings = data["warnings"] as? [String] ?? []
                let ingredients = data["ingredients"] as? [String: Int] ?? [:]
                let image = data["image"] as? Data ?? (UIImage(named: "defaultMenuItemImage")!).pngData()!
                
                let deserialisedImage = UIImage(data: image)!

                return MenuItemModel(id: id, price: Decimal(price), estimatedServingTime: estimatedServingTime, warnings: warnings, ingredients: ingredients, image: deserialisedImage)
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

class InventoryRepository: ObservableObject {
    
    private let db = Firestore.firestore()
    var inventory = [IngredientModel]()
    
    func fetchInventory() -> [IngredientModel] {
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

                return IngredientModel(id: id, units: units, currentStock: Decimal(currentStock), minimumThreshold: Decimal(minimumThreshold), costPerUnit: Decimal(costPerUnit), warnings: warnings, comment: comment)
            }
        }
        
        return inventory
    }
    
    func addIngredient(ingredient: IngredientModel) -> String {
        let docRef = db.collection("inventory").document(ingredient.id!)
        
        do {
            try docRef.setData(from: ingredient)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }
    
    func removeIngredient(name: String) {
        db.collection("inventory").document(name).delete() { err in // function doesn't throw?
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
