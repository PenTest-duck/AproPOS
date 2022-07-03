//
//  BillingModel.swift
//  AproPOS UI
//
//  Created by Kushaagra Kesarwani on 22/6/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

struct BillingModel: Identifiable, Codable {
    @DocumentID public var id: String?
    //var orderID: DocumentReference
    var orderID: String
    var startTimeEvent: Date
    var subtotalPrice: Decimal
    var discount: Decimal
    var totalPrice: Decimal
    
    init(id: String = UUID().uuidString, orderID: String, startTimeEvent: Date = Date(), subtotalPrice: Decimal, discount: Decimal, totalPrice: Decimal) {
        self.id = id
        self.orderID = orderID
        self.startTimeEvent = startTimeEvent
        self.subtotalPrice = subtotalPrice
        self.discount = discount
        self.totalPrice = totalPrice
    }
}
