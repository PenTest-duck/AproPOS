//
//  OrderModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 12/5/22.
//

import Foundation

struct OrderModel: Identifiable {
    var id: String = UUID().uuidString
    var tableNumber: Int
    var startTimeEvent: Date
    var startTime: String { // From: https://medium.com/swift-productions/convert-date-into-string-from-firestore-swiftui-a70a9297e0af
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: startTimeEvent)
    }
    var status: String // preparing, served, paid
    var orderedMenuItems: [[String: Int]]

}

extension OrderModel: Equatable {}
