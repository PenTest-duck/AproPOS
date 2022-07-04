//
//  BillingModel.swift
//  AproPOS UI
//
//  Created by Kushaagra Kesarwani on 22/6/22.
//

import Foundation
import FirebaseFirestoreSwift

struct BillingModel: Identifiable, Codable {
    @DocumentID public var id: String?
    var tableNumber: String
    var order: OrderModel
    var discount: Decimal
    var totalPrice: Decimal
    var billingTime: Date
    var server: String
    
    init(id: String = UUID().uuidString, tableNumber: String, order: OrderModel, discount: Decimal, totalPrice: Decimal, billingTime: Date = Date(), server: String) {
        self.id = id
        self.tableNumber = tableNumber
        self.order = order
        self.discount = discount
        self.totalPrice = totalPrice
        self.billingTime = billingTime
        self.server = server
    }
}
