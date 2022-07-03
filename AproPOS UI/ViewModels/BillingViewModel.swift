//
//  BillingViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 23/6/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

/*
final class BillingViewModel: ObservableObject {
    @Published var bills = [BillingModel]()
    @Published var billingRepository = BillingRepository()
    
    @Published var discountInput: Decimal = 0
    /*
    func addBill() {
        let newBill = BillingModel(orderID: <#T##String#>, subtotalPrice: <#T##Decimal#>, discount: discountInput, totalPrice: <#T##Decimal#>)
        if newOrder.tableNumber == 0 {
            message = "Invalid table number"
        } else {
            message = billingRepository.addBill(bill: newBill)
        }
    }*/
    
    func getBills() {
        bills = billingRepository.fetchBills() // first time it doesn't fill it up?
        print(bills) // for debugging
    }
    
}
*/
