//
//  OrderViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 21/5/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import SwiftUI

final class OrderViewModel: ObservableObject {
    @Published var orders = [OrderModel]()
    @Published var orderRepository = OrderRepository()
    @Published var tableRepository = TableRepository()
    private let db = Firestore.firestore()
    
    @Published var error = ""
    @Published var orderStatistics: [String: Int] = ["total": 0, "preparing": 0, "overdue": 0, "served": 0]
    @Published var editingOrder = false
    
    @Published var tableNumberInput: String = "0"
    @Published var menuItemsInput: [OrderedMenuItem] = []
    
    func addOrder(completion: @escaping (_ success: Bool) -> Void) {
        tableRepository.fetchTables() { (fetchedTables) -> Void in
            if self.tableNumberInput == "" {
                self.error = "Please enter a table number"
            } else if self.tableNumberInput == "0" {
                self.error = "Invalid table number"
            } else if !self.editingOrder && self.orders.firstIndex(where: { $0.id == self.tableNumberInput }) != nil {
                self.error = "Order already exists for table"
            } else if fetchedTables.firstIndex(where: { $0.id == self.tableNumberInput } ) == nil {
                self.error = "Table does not exist"
            } else if self.menuItemsInput == [] {
                self.error = "Please select at least 1 menu item"
            } else {
                // TODO: Refresh subtotalPrice when ordering
                self.orderRepository.reduceInventory(menuItems: self.menuItemsInput) { (result) -> Void in
                    if result == "success" {
                        //self.orderRepository.addOrder(id: self.tableNumberInput, menuItems: self.menuItemsInput)
                        let newOrder = OrderModel(id: self.tableNumberInput, menuItems: self.menuItemsInput, subtotalPrice: self.totalPrice())
                        self.orderRepository.addOrder(order: newOrder)
                        self.error = ""
                    } else {
                        self.error = "Not enough \(result)"
                    }
                    completion(true)
                }
            }
        }
    }
    
    func getOrders() {
        orderRepository.fetchOrders() { (fetchedOrders) -> Void in
            self.orders = fetchedOrders
            
            let total = fetchedOrders.count
            let preparing = fetchedOrders.filter( { $0.status == "preparing" } ).count
            let overdue = fetchedOrders.filter( { $0.status == "overdue" } ).count
            let served = fetchedOrders.filter( { $0.status == "served" } ).count
            self.orderStatistics = ["total": total, "preparing": preparing, "overdue": overdue, "served": served]
        }
    }
    
    func removeOrder() {
        orderRepository.removeOrder(tableNumber: tableNumberInput)
    }
    
    func editOrder() {
        guard let originalOrder = orders.first(where: { $0.id == tableNumberInput }) else {
            print("Order doesn't exist")
            return
        }
        
        var originalMenuItems: [OrderedMenuItem] = []
        for menuItem in originalOrder.menuItems {
            originalMenuItems.append(menuItem)
        }
        let editedMenuItems = menuItemsInput == [] ? originalMenuItems : menuItemsInput
        
        let editedOrder = OrderModel(id: tableNumberInput, menuItems: editedMenuItems, subtotalPrice: totalPrice())
        
        orderRepository.addOrder(order: editedOrder)
    }
    
    func changeOrderStatus(tableNumber: String, status: String) {
        orderRepository.changeOrderStatus(tableNumber: tableNumber, status: status)
    }
    
    func calculateEST(menuItems: [OrderedMenuItem], completion: @escaping (Int) -> Void) {
        var total = 0
        MenuRepository().fetchMenu() { (fetchedMenu) -> Void in
            for menuItem in menuItems {
                total += fetchedMenu.first(where: { $0.id == menuItem.name } )!.estimatedServingTime
            }
            
            completion(total)
        }
    }
    
    func initPrice(name: String, completion: @escaping (Decimal) -> Void) {
        db.collection("menu").document(name).getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("No documents")
                return
            }

            let data = document.data()
            let price = data!["price"] as? Double ?? 0.0
            
            completion(Decimal(price))
        }
    }
    
    func totalPrice() -> Decimal {
        var total: Decimal = 0.00
        for menuItem in menuItemsInput {
            total += menuItem.price
        }
        return total
    }
    
    func toggleMenuItemServed(tableNumber: String, menuItems: [OrderedMenuItem], name: String) {
        orderRepository.toggleMenuItemServed(tableNumber: tableNumber, menuItems: menuItems, name: name) { (_ success) -> Void in
            
        }
    }
}
