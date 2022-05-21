//
//  OrderModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 12/5/22.
//

import Foundation

struct OrderModel: Identifiable {
    let id: String
    var tableNumber: Int
    var startTimeEvent: Date
    var startTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: startTimeEvent)
    }
    var status: String // preparing, served, paid
    var orderedMenuItems: [[String: Int]]
    
    init(id: String = UUID().uuidString, tableNumber: Int, startTimeEvent: Date, status: String = "preparing", orderedMenuItems: [[String: Int]]) {
        self.id = id
        self.tableNumber = tableNumber
        self.startTimeEvent = startTimeEvent // huihiuhiuhuou
        self.status = status
        self.orderedMenuItems = orderedMenuItems
    }
}

extension OrderModel: Equatable {}
