//
//  OrderModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 12/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct OrderModel: Identifiable, Codable, Equatable {
    @DocumentID public var id: String? // table number
    var orderTime: Date
    var status: String // preparing, overdue, served
    var menuItems: [OrderedMenuItem]
    var subtotalPrice: Decimal
    
    init(id: String = UUID().uuidString, orderTime: Date = Date(), status: String = "preparing", menuItems: [OrderedMenuItem], subtotalPrice: Decimal = 0.00) {
        self.id = id
        self.orderTime = orderTime
        self.status = status
        self.menuItems = menuItems
        self.subtotalPrice = subtotalPrice
    }

}

struct OrderedMenuItem: Codable, Equatable {
    var name: String
    var quantity: Int
    var price: Decimal
    var served: Bool
    
    init(name: String, quantity: Int, price: Decimal, served: Bool = false) {
        self.name = name
        self.quantity = quantity
        self.price = price
        self.served = served
    }
}
