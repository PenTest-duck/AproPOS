//
//  BillingViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 23/6/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class BillingViewModel: ObservableObject {
    @Published var billOrders = [OrderModel]()
    @Published var billsHistory = [BillingModel]()
    @Published var orderRepository = OrderRepository()
    
    @Published var tableNumberInput: String = ""
    @Published var discountInput: Decimal = 0.00
    @Published var serverInput: String = "" // TODO: current user auth features
    
    func getOrders() {
        billOrders = orderRepository.fetchOrders() // first time it doesn't fill it up?
    }
    
    func processBill() {
        orderRepository.processBill(tableNumber: tableNumberInput, discount: discountInput, server: serverInput)
    }
    
    func getBillsHistory() {
        billsHistory = orderRepository.fetchBills()
    }
}

