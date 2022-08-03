//
//  AnalyticsViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 5/7/22.
//

import Foundation

// Code from here is created by Kushaagra Kesarwani on 22/7/22

final class AnalyticsViewModel: ObservableObject {
    @Published var billingRepository = BillingRepository()
    @Published var billsHistory = [BillingModel]()
    @Published var totalIncome: Decimal = 0
    
    func fetchBills() {
        billingRepository.fetchBills() { (fetchedBills) -> Void in
            self.billsHistory = fetchedBills
        }
    }
    func addBillPrice() {
        
        totalIncome = 0
        for bill in billsHistory {
            totalIncome += bill.totalPrice
            }
        }
    /*func getBillsHistory(totalPrice: Decimal) -> Decimal {
        fetchBills()
        var totalIncome: Decimal = 0
        totalIncome += totalPrice
        output = totalIncome
        return totalIncome
    }*/
}

