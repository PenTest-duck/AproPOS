//
//  TableModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation
import FirebaseFirestoreSwift

struct TableModel: Identifiable, Codable, Equatable {
    @DocumentID public var id: String? // Unique table number
    var seats: Int // 1 to 20
    var status: String // Free, yetToOrder, ordered, served, cleaning, reserved, unavailable
    
    init(id: String = UUID().uuidString, seats: Int, status: String = "free") {
        self.id = id
        self.seats = seats
        self.status = status
    }
}
