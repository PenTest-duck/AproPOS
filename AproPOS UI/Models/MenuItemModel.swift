//
//  MenuItemModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit

struct MenuItemModel: Identifiable {
    @DocumentID public var id: String?
    var name: String
    var price: Decimal
    var estimatedServingTime: Int // minutes
    var warnings: [String]
    var ingredients: [String: Int]
    var image: UIImage // needed to import UIKit
    
    init(id: String = UUID().uuidString, name: String, price: Decimal, estimatedServingTime: Int, warnings: [String], ingredients: [String: Int], image: UIImage) {
        self.id = id
        self.name = name
        self.price = price
        self.estimatedServingTime = estimatedServingTime
        self.warnings = warnings
        self.ingredients = ingredients
        self.image = image
    }
}
