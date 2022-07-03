//
//  TableModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation
import FirebaseFirestoreSwift

struct TableModel: Identifiable, Codable {
    @DocumentID public var id: String? // table number
    var seats: Int
    var status: String
    
    init(id: String = UUID().uuidString, seats: Int, status: String = "free") {
        self.id = id
        self.seats = seats
        self.status = status
    }
}
