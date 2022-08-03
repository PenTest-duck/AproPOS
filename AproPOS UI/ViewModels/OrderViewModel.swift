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
    // Repository and storage
    @Published var orders = [OrderModel]()
    @Published var orderRepository = OrderRepository()
    @Published var tableRepository = TableRepository()
    private let db = Firestore.firestore()
    
    // Error field
    @Published var error = ""

    // Input fields
    @Published var tableNumberInput: String = "0"
    @Published var menuItemsInput: [OrderedMenuItem] = []
    
    // Order statistics output
    @Published var orderStatistics: [String: Int] = ["total": 0, "preparing": 0, "overdue": 0, "served": 0]
    
    // System fields
    @Published var editingOrder = false
    
    // TODO: va
    func validateInput(fetchedTables: [TableModel]) {
        // Define table statuses that allow ordering
        let statuses = ["free", "yetToOrder", "reserved"]
        
        if self.tableNumberInput == "" { // Check if table number is empty
            self.error = "Please enter a table number"
        } else if self.tableNumberInput == "0" { // Check if table number is zero
            self.error = "Invalid table number"
        } else if !self.editingOrder // Check if not editing order; if editing, table may already exist
            && self.orders.firstIndex(where: { $0.id == self.tableNumberInput }) != nil // Check if order with table number exists
            && (self.orders.first(where: { $0.id == self.tableNumberInput }) ?? OrderModel(status: "x", menuItems: [], estimatedServingTime: 0)).status != "served" { // Check if order status is served; if order does not exist, this condition succeeds
            self.error = "Order already exists for table"
        } else if fetchedTables.firstIndex(where: { $0.id == self.tableNumberInput } ) == nil { // Check if table exists
            self.error = "Table does not exist"
        } else if self.menuItemsInput == [] { // Check if menu items is empty
            self.error = "Please select at least 1 menu item"
        } else if !self.editingOrder && !statuses.contains(fetchedTables.first(where: { $0.id == self.tableNumberInput } )!.status) { // Check if table's status does not belong to the statuses that allow ordering
            self.error = "Table is not available"
        } else {
            self.error = ""
        }
    }
    
    // Retrieves all orders and stores them in <orders>
    // Can be run once, and will asynchronously update if there are changes to the database
    func getOrders() {
        orderRepository.fetchOrders() { (fetchedOrders) -> Void in // Await completion of fetchOrders()
            self.orders = fetchedOrders
            
            // Get statistic values for total, preparing, overdue, and served orders
            let total = fetchedOrders.count
            let preparing = fetchedOrders.filter( { $0.status == "preparing" } ).count
            let overdue = fetchedOrders.filter( { $0.status == "overdue" } ).count
            let served = fetchedOrders.filter( { $0.status == "served" } ).count
            
            self.orderStatistics = ["total": total, "preparing": preparing, "overdue": overdue, "served": served]
        }
    }
    
    // Adds a new order to the database, by first validating the input
    func addOrder(completion: @escaping (_ success: Bool) -> Void) {
        tableRepository.fetchTables() { (fetchedTables) -> Void in // Awaits completion of fetchTables()
            self.validateInput(fetchedTables: fetchedTables)
            
            if self.error == "" {
                // TODO: Refresh subtotalPrice when ordering
                // Reduce the inventory then add the order
                self.orderRepository.reduceInventory(menuItems: self.menuItemsInput) { (result) -> Void in // Awaits completion of reduceInventory()
                    if result == "success" {
                        // Create new OrderModel
                        self.calculateEST(menuItems: self.menuItemsInput) { (EST) -> Void in
                            let newOrder = OrderModel(id: self.tableNumberInput, menuItems: self.menuItemsInput, subtotalPrice: self.totalPrice(), estimatedServingTime: EST)
                            
                            // Add to database
                            self.orderRepository.addOrder(order: newOrder)
                        }
                    } else {
                        // Error with name of insufficient ingredient
                        self.error = "Not enough \(result)"
                    }
                    
                    // Need to return success as true for completion closure
                    completion(true)
                }
            }
        }
    }
    
    // Remove existing order
    func removeOrder() {
        orderRepository.removeOrder(tableNumber: tableNumberInput)
    }
    
    // Edit existing order
    func editOrder() {
        // Check if order exists
        guard let originalOrder = orders.first(where: { $0.id == tableNumberInput }) else {
            print("Order doesn't exist")
            return
        }
        
        // Store all existing menu items in an array
        var originalMenuItems: [OrderedMenuItem] = []
        for menuItem in originalOrder.menuItems {
            originalMenuItems.append(menuItem)
        }
        
        // Check if menu items input is empty, retain the original value if it is, and use the new value if it isn't
        let editedMenuItems = menuItemsInput == [] ? originalMenuItems : menuItemsInput
        
        self.calculateEST(menuItems: self.menuItemsInput) { (EST) -> Void in
            // Create edited OrderModel
            let editedOrder = OrderModel(id: self.tableNumberInput, menuItems: editedMenuItems, subtotalPrice: self.totalPrice(), estimatedServingTime: EST)
            
            self.orderRepository.addOrder(order: editedOrder)
            
            if self.tableNumberInput != originalOrder.id {
                self.orderRepository.removeOrder(tableNumber: originalOrder.id!)
            }
        }
    }
    
    // Change the status of an existing order
    func changeOrderStatus(tableNumber: String, status: String) {
        orderRepository.changeOrderStatus(tableNumber: tableNumber, status: status)
    }
    
    // Add all EST of menu items to find the order EST
    func calculateEST(menuItems: [OrderedMenuItem], completion: @escaping (Int) -> Void) {
        var total = 0
        MenuRepository().fetchMenu() { (fetchedMenu) -> Void in // Awaits completion of fetchMenu()
            // Iterate over menu items and add their ESTs
            for menuItem in menuItems {
                total += (fetchedMenu.first(where: { $0.id == menuItem.name } ) ?? MenuItemModel(price: 0, estimatedServingTime: 0)).estimatedServingTime
            }
            
            completion(total)
        }
    }
    
    // Determine the price of a menu item (quantity 1)
    func initPrice(name: String, completion: @escaping (Decimal) -> Void) {
        db.collection("menu").document(name).getDocument { (document, error) in // Get specific menu document (not synchronised)
            // Error handling when document does not exist
            guard let document = document, document.exists else {
                print("No documents")
                return
            }

            // Extract price from data
            let data = document.data()
            let price = data!["price"] as? Double ?? 0.0
            
            completion(Decimal(price))
        }
    }
    
    // Add all subtotals of menu items to calculate the total price
    func totalPrice() -> Decimal {
        var total: Decimal = 0.00
        
        // Iterate over every menu item an add subtotal to total
        for menuItem in menuItemsInput {
            total += menuItem.price
        }
        return total
    }
    
    // Toggle the "served" value of a menu item
    func toggleMenuItemServed(tableNumber: String, menuItems: [OrderedMenuItem], name: String) {
        orderRepository.toggleMenuItemServed(tableNumber: tableNumber, menuItems: menuItems, name: name) { (_ success) -> Void in // Await completion of toggleMenuItemServed()
            
            // Intentionally empty closure as no action is required; the function just awaits the completion
        }
    }
    
    // Monitor elapsed and estimated time of each preparing order and change to "overdue" if necessary
    func monitorOverdue() {
        for order in orders {
            if order.status == "preparing" {
                let now = Date()
                let deadline = order.orderTime.addingTimeInterval(Double(order.estimatedServingTime * 60)) // estimated finish time
                
                // If the current time is past the estimated finish time, change order to "overdue"
                if now > deadline {
                    changeOrderStatus(tableNumber: order.id!, status: "overdue")
                }
            }
        }
    }
    
    var timer = Timer()
    
    // Starts the routine monitoring of overdue orders
    func viewDidLoad() {
        // Every 5 seconds, call the monitorOverdue() function
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            self.monitorOverdue()
        })
    }
}
