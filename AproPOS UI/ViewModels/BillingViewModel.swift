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
    // Repositories and storage
    @Published var billOrders = [OrderModel]()
    @Published var billsHistory = [BillingModel]()
    @Published var users = [UserModel]()
    @Published var orderRepository = OrderRepository()
    @Published var billingRepository = BillingRepository()
    @Published var userRepository = UserRepository()
    
    // Error field
    @Published var error = ""
    
    // Input fields
    @Published var tableNumberInput: String = ""
    @Published var discountInput: String = "0.00"
    
    // System fields
    @Published var selectedOrder: OrderModel? = nil
    @Published var server: String = ""
    @Published var viewingPastBill = false
    
    // Validates discount input
    func validateDiscount(discount: String, subtotal: Decimal) {
        if discount == "" { // Check if discount is empty
            error = "Please enter a valid discount amount"
        } else if discount[(discount.firstIndex(of: ".") ?? discount.index(discount.endIndex, offsetBy: -1))...].count > 3 { // Check if discount contains more than two decimal digits
            error = "Currency allows max. 2 decimal places"
        } else if Decimal(Double(discount)!) > subtotal { // Check if discount is greater than the subtotal
            error = "Discount cannot be larger than the subtotal price."
        } else {
            error = ""
        }
    }
    
    // Retrieves all orders and stores them in billOrders
    // Can be run once, and will asynchronously update if there are changes to the database
    func getOrders() {
        orderRepository.fetchOrders() { (fetchedOrders) -> Void in // Awaits until completion of fetchOrders()
            self.billOrders = fetchedOrders
        }
    }
    
    // Retrieves all bills and stores them in billsHistory
    func getBillsHistory() {
        billingRepository.fetchBills() { (fetchedBills) -> Void in // Awaits until completion of fetchBills()
            self.billsHistory = fetchedBills
        }
    }
    
    // Processes the order, converting it into a bill and updating the database
    func processBill() {
        // Get UserModel of currently logged-in user
        let currentUser = self.users.first(where: { $0.id == Auth.auth().currentUser!.email! } )!
        
        self.billingRepository.processBill(tableNumber: self.tableNumberInput, discount: Decimal(Double(self.discountInput)!), server: "\(currentUser.firstName) \(currentUser.lastName)")
    }
    
    // Retrieves all users and stores them in <users>
    func getUsers() {
        userRepository.fetchUsers() { (fetchedUsers) -> Void in // Awaits until completion of fetchUsers()
            self.users = fetchedUsers
        }
    }
}

