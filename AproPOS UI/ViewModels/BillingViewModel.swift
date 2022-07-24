//
//  BillingViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 23/6/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

final class BillingViewModel: ObservableObject {
    @Published var billOrders = [OrderModel]()
    @Published var billsHistory = [BillingModel]()
    @Published var orderRepository = OrderRepository()
    @Published var billingRepository = BillingRepository()
    
    @Published var error = ""
    
    @Published var tableNumberInput: String = ""
    @Published var discountInput: String = "0.00"
    
    @Published var selectedOrder: OrderModel? = nil
    @Published var viewingPastBill = false
    
    func validateDiscount(discount: String) {
        if discount == "" {
            error = "Please enter a valid discount amount"
        } else if discount[(discount.firstIndex(of: ".") ?? discount.index(discount.endIndex, offsetBy: -1))...].count > 3 {
            error = "Currency allows max. 2 decimal places"
        //} else if Decimal(discount) >  {
            
        } else {
            error = ""
        }
    }
    
    func getOrders() {
        orderRepository.fetchOrders() { (fetchedOrders) -> Void in
            self.billOrders = fetchedOrders
        }
    }
    
    func processBill() {
        UserRepository().fetchUsers() { (fetchedUsers) -> Void in
            let currentUser = fetchedUsers.first(where: { $0.id == Auth.auth().currentUser!.email! } )!
            self.billingRepository.processBill(tableNumber: self.tableNumberInput, discount: Decimal(Double(self.discountInput)!), server: "\(currentUser.firstName) \(currentUser.lastName)")
        }
    }
    
    func getBillsHistory() {
        billingRepository.fetchBills() { (fetchedBills) -> Void in
            self.billsHistory = fetchedBills
        }
    }
}

