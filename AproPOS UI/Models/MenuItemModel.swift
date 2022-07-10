//
//  MenuItemModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit // for UIImage

struct MenuItemModel: Identifiable, Codable, Equatable {
    @DocumentID public var id: String?
    var price: Decimal
    var estimatedServingTime: Int // minutes
    var warnings: [String] // vegetarian, vegan, gluten, allergen, alcohol
    var ingredients: [String: Decimal]
    var image: Data // to conform to Codable
    var status: [String: [String]] // available, unavailable
    
    init(id: String = UUID().uuidString, price: Decimal, estimatedServingTime: Int, warnings: [String] = [], ingredients: [String: Decimal] = [:], image: UIImage = UIImage(named: "defaultMenuItemImage")!, status: [String: [String]] = ["available": []]) {
        self.id = id
        self.price = price
        self.estimatedServingTime = estimatedServingTime
        self.warnings = warnings
        self.ingredients = ingredients
        self.image = image.pngData()!
        self.status = status
    }
}
