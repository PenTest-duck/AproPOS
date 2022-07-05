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
                let orderTime = (data["orderTime"] as? Timestamp)?.dateValue() ?? Date()
                let status = data["status"] as? String ?? ""
                let menuItems = data["menuItems"] as? [[String: Any]] ?? []
                let subtotalPrice = data["subtotalPrice"] as? Double ?? 0.00
                
                let convertedMenuItems = self.convertMenuItems(menuItems: menuItems)

                return OrderModel(id: id, orderTime: orderTime, status: status, menuItems: convertedMenuItems, subtotalPrice: Decimal(subtotalPrice))
            }
            
            print(self.orders)
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
    
    func addOrder(id: String, menuItems: [String: Int]) {
        db.collection("menu").getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // TODO: Limit order availability

            self.menuPrices = documents.map { queryDocumentSnapshot -> [String: Decimal] in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let price = data["price"] as? Double ?? 0.00

                return [id: Decimal(price)]
            }
            
            var orderedMenuItems: [OrderedMenuItem] = []
            
            for menuItem in menuItems {
                let menuItemPrice = (self.menuPrices.compactMap { $0[menuItem.key] })[0]
                orderedMenuItems.append(OrderedMenuItem(name: menuItem.key, quantity: menuItem.value, price: menuItemPrice * Decimal(menuItem.value)))
                self.subtotalPrice += menuItemPrice * Decimal(menuItem.value)
            }
            
            // Add Order:
            let newOrder = OrderModel(id: id, menuItems: orderedMenuItems, subtotalPrice: self.subtotalPrice)
            let docRef = self.db.collection("orders").document(newOrder.id!)
            
            do {
                try docRef.setData(from: newOrder)
                print("success")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func reduceInventory(menuItems: [String: Int]) {
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
                let ingredients = (self.menuIngredients.compactMap { $0[menuItem.key] })[0]
                for ingredient in ingredients {
                    self.db.collection("inventory").document(ingredient.key).updateData(["currentStock": FieldValue.increment(-Double(ingredient.value * menuItem.value))])
                }
            }
            
        }
    }
    

    func editOrder(id: String, newMenuItems: [String: Int]) {
        // TODO: Edit order with checking availability
        
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
    
    func changeOrderStatus(tableNumber: String, status: String) {
        db.collection("orders").document(tableNumber).updateData(["status": status]) { err in // function doesn't throw?
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
            
            let convertedMenuItem = OrderedMenuItem(name: menuItemName, quantity: menuItemQuantity, price: Decimal(menuItemPrice))
            convertedMenuItems.append(convertedMenuItem)
        }
        
        return convertedMenuItems
    }
    
    // Billing
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
        }
    }
    
    func fetchBills() -> [BillingModel] {                                                               // Possibly don't need to return?
        db.collection("billsHistory").getDocuments() { (querySnapshot, error) in
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
        }
        
        return billsHistory
    }
    
}

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
                let status = data["status"] as? String ?? "available"

                return IngredientModel(id: id, units: units, currentStock: Decimal(currentStock), minimumThreshold: Decimal(minimumThreshold), costPerUnit: Decimal(costPerUnit), warnings: warnings, comment: comment, status: status)
            }
            
            // Monitor inventory status
            self.monitorInventory()
        }
        
        return inventory
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

class TableRepository: ObservableObject { // for the table view and status etc
    
    private let db = Firestore.firestore() // get the db
    var tables = [TableModel]()  // referring to the table model file

    func fetchTables() -> [TableModel] { //gets info from table models
        db.collection("tables").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.tables = documents.map { queryDocumentSnapshot -> TableModel in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                let seats = data["seats"] as? Int ?? 0
                let status = data["status"] as? String ?? "free"

                return TableModel(id: id, seats: seats, status: status)
            }
            
            print(self.tables)
        }
        return tables
    }
    
    func addTable(table: TableModel) -> String {
        let docRef = db.collection("tables").document(table.id!)
        
        do {
            try docRef.setData(from: tables)
            return "success"
        } catch {
            return error.localizedDescription
        }
    }
    
    func removeTable(tableNumber: String) {
        db.collection("tables").document(tableNumber).delete() { err in // function doesn't throw?
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
