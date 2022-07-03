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

    private let db = Firestore.firestore()

    /*func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date())
    }*/
    
    func addOrder() { // Convert tableNumber from String to Int
        let validatedTableNumberInput = Int(tableNumberInput) ?? 0
        
        if validatedTableNumberInput == 0 {
            message = "Invalid table number"
        } else {
            // TODO: Refresh subtotalPrice when ordering
            
            message = orderRepository.addOrder(tableNumber: validatedTableNumberInput, menuItems: menuItemsInput)
            
            //let newOrder = OrderModel(tableNumber: validatedTableNumberInput, menuItems: menuItemsInput)//, subtotalPrice: subtotalPrice)
            //message = orderRepository.addOrder(order: newOrder)
            
            // TODO: Reduce inventory
            orderRepository.reduceInventory(menuItems: menuItemsInput)
        }
    }
    
    func getOrders() {
        orders = orderRepository.fetchOrders() // first time it doesn't fill it up?
        print(orders) // for debugging
    }
}
