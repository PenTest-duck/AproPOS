//
//  OrderModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 12/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct OrderModel: Identifiable, Codable {
    @DocumentID public var id: String?
    var tableNumber: Int
    var startTimeEvent: Date
    var status: String // preparing, served, paid
    var orderedMenuItems: [String: Int] // could possibly make this into a [MenuItemModel] ?
    
    init(id: String = UUID().uuidString, tableNumber: Int, startTimeEvent: Date = Date(), status: String = "preparing", orderedMenuItems: [String: Int]) {
        self.id = id
        self.tableNumber = tableNumber
        self.startTimeEvent = startTimeEvent
        self.status = status
        self.orderedMenuItems = orderedMenuItems
    }

}
