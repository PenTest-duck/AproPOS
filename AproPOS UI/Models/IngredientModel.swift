//
//  IngredientModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation
import FirebaseFirestoreSwift

struct IngredientModel: Identifiable, Codable, Equatable {
    @DocumentID public var id: String? // Unique name of ingredient
    var units: String
    var currentStock: Decimal
    var minimumThreshold: Decimal
    var costPerUnit: Decimal
    var warnings: [String] // TODO: 
    var comment: String
    var status: String // Unavailable, low, available
    
    init(id: String = UUID().uuidString, units: String, currentStock: Decimal = 0, minimumThreshold: Decimal, costPerUnit: Decimal = 0, warnings: [String] = [], comment: String = "", status: String = "available") {
        self.id = id
        self.units = units
        self.currentStock = currentStock
        self.minimumThreshold = minimumThreshold
        self.costPerUnit = costPerUnit
        self.warnings = warnings
        self.comment = comment
        self.status = status
    }
}
