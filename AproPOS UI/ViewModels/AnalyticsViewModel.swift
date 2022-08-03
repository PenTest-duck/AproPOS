//
//  AnalyticsViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 5/7/22.
//

import Foundation

// Code from here is created by Kushaagra Kesarwani & Chris Yoo

final class AnalyticsViewModel: ObservableObject {
    @Published var billingRepository = BillingRepository()
    @Published var billsHistory = [BillingModel]()
    @Published var totalIncome: Decimal = 0
    
    @Published var menuItemStatistics: [String: Int] = [:]
    @Published var sortedMenuItemStatistics: [Dictionary<String, Int>.Element] = []
    
    func addBillPrice() {
        totalIncome = 0
        for bill in billsHistory {
            totalIncome += bill.totalPrice
        }
    }
    
    func sortMenuItemsByPopularity() {
        billingRepository.fetchBills() { (fetchedBills) -> Void in // Awaits until completion of fetchBills()
            self.billsHistory = fetchedBills
                                                
            for bill in fetchedBills {
                for menuItem in bill.order.menuItems {
                    if self.menuItemStatistics.firstIndex(where: { $0.key == menuItem.name }) == nil {
                        self.menuItemStatistics[menuItem.name] = menuItem.quantity
                    } else {
                        self.menuItemStatistics[menuItem.name]! += menuItem.quantity
                    }
                }
            }
            
            self.sortedMenuItemStatistics = self.menuItemStatistics.sorted(by: { $0.value > $1.value } )
        }
    }
}

