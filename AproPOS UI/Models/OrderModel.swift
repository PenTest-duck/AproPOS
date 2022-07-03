//
//  OrderModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 12/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct OrderModel: Identifiable, Codable {
    @DocumentID public var id: String? // table number
    var startTimeEvent: Date
    var status: String // preparing, served, paid
    var menuItems: [String: Int]
    var subtotalPrice: Decimal
    
    init(id: String = UUID().uuidString, startTimeEvent: Date = Date(), status: String = "preparing", menuItems: [String: Int], subtotalPrice: Decimal = 0.00) {
        self.id = id
        self.startTimeEvent = startTimeEvent
        self.status = status
        self.menuItems = menuItems
        self.subtotalPrice = subtotalPrice
    }

}
