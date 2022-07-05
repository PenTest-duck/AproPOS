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
    @Published var billingRepository = BillingRepository()
    
    @Published var tableNumberInput: String = ""
    @Published var discountInput: Decimal = 0.00
    @Published var serverInput: String = "" // TODO: current user auth features
    
    func getOrders() {
        orderRepository.fetchOrders() { (fetchedOrders) -> Void in
            self.billOrders = fetchedOrders
        }
    }
    
    func processBill() {
        billingRepository.processBill(tableNumber: tableNumberInput, discount: discountInput, server: serverInput)
    }
    
    func getBillsHistory() {
        billingRepository.fetchBills() { (fetchedBills) -> Void in
            self.billsHistory = fetchedBills
        }
    }
}

