//
//  IngredientModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation
import FirebaseFirestoreSwift

struct IngredientModel: Identifiable, Codable {
    @DocumentID public var id: String? // name
    var units: String
    var currentStock: Decimal
    var minimumThreshold: Decimal
    var costPerUnit: Decimal
    var warnings: [String]
    var comment: String
    
    init(id: String = UUID().uuidString, units: String, currentStock: Decimal = 0, minimumThreshold: Decimal, costPerUnit: Decimal = 0, warnings: [String] = [], comment: String = "") {
        self.id = id
        self.units = units
        self.currentStock = currentStock
        self.minimumThreshold = minimumThreshold
        self.costPerUnit = costPerUnit
        self.warnings = warnings
        self.comment = comment
    }
}
