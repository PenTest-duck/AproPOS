//
//  OrderViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 21/5/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class OrderViewModel: ObservableObject {
    @Published var orders = [OrderModel]()
    @Published var orderRepository = OrderRepository()
    
    @Published var error = ""
    
    @Published var tableNumberInput: String = ""
    @Published var menuItemsInput: [OrderedMenuItem] = [] // [String: Int] = [:]

    /*func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date())
    }*/
    
    func addOrder() { // Convert tableNumber from String to Int
        if tableNumberInput == "0" {
            error = "Invalid table number"
        } else if orders.firstIndex(where: { $0.id == tableNumberInput }) != nil {            // orders needs to update beforehand
            error = "Order already exists"
        } else {
            // TODO: Refresh subtotalPrice when ordering
            orderRepository.reduceInventory(menuItems: menuItemsInput)
            orderRepository.addOrder(id: tableNumberInput, menuItems: menuItemsInput)
        }
    }
    
    func getOrders() {
        orderRepository.fetchOrders() { (fetchedOrders) -> Void in
            self.orders = fetchedOrders
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
        
        orderRepository.addOrder(id: tableNumberInput, menuItems: editedMenuItems)
    }
    
    func changeOrderStatus(tableNumber: String, status: String) {
        orderRepository.changeOrderStatus(tableNumber: tableNumber, status: status)
    }
}
