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
    @Published var orderedMenuItemsInput: [String: Int] = [:]
    
    @Published var message = ""
    
    /*func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date())
    }*/
    
    func addOrder(tableNumber: String, orderedMenuItems: [String: Int]) { // Convert tableNumber from String to Int
        let newOrder = OrderModel(tableNumber: (Int(tableNumberInput) ?? 0), orderedMenuItems: orderedMenuItemsInput)
        message = orderRepository.addOrder(order: newOrder)
    }
    
    func getOrders() {
        orders = orderRepository.fetchOrders() // first time it doesn't fill it up?
        print(orders)
    }

}
