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
    
    @Published var tableNumberInput: String = ""
    @Published var menuItemsInput: [String: Int] = [:]
    
    @Published var message = ""

    /*func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date())
    }*/
    
    func addOrder() { // Convert tableNumber from String to Int
        if tableNumberInput == "0" {
            message = "Invalid table number"
        } else if orders.firstIndex(where: { $0.id == tableNumberInput }) != nil {            // orders needs to update beforehand
            message = "Order already exists"
        } else {
            // TODO: Refresh subtotalPrice when ordering
            orderRepository.reduceInventory(menuItems: menuItemsInput)
            orderRepository.addOrder(id: tableNumberInput, menuItems: menuItemsInput)
        }
    }
    
    func getOrders() {
        orders = orderRepository.fetchOrders() // first time it doesn't fill it up?
    }
    
    func removeOrder(tableNumber: String) {
        orderRepository.removeOrder(tableNumber: tableNumber)
    }
    
    func editOrder() { 
        if tableNumberInput == "0" {
            message = "Invalid table number"
        } else if orders.firstIndex(where: { $0.id == tableNumberInput }) == nil {            // orders needs to update beforehand
            message = "Order does not exist"
        } else {
            orderRepository.editOrder(id: tableNumberInput, newMenuItems: menuItemsInput)
        }
    }
    
    func changeOrderStatus(tableNumber: String, status: String) {
        orderRepository.changeOrderStatus(tableNumber: tableNumber, status: status)
    }
}
