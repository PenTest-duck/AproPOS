//
//  MenuItemModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit // only for UIImage

struct MenuItemModel: Identifiable, Codable, Equatable {
    @DocumentID public var id: String? // Unique name of menu item
    var price: Decimal
    var estimatedServingTime: Int // In minutes
    var warnings: [String] // TODO: vegetarian, vegan, gluten, allergen, alcohol
    var ingredients: [String: Decimal]
    var image: Data // Must use Data instead of UIImage to conform to Codable
    var status: [String: [String]] // Available or unavailable as the key, array of low ingredients in value
    
    init(id: String = UUID().uuidString, price: Decimal, estimatedServingTime: Int, warnings: [String] = [], ingredients: [String: Decimal] = [:], image: UIImage = UIImage(named: "defaultMenuItemImage")!, status: [String: [String]] = ["available": []]) {
        self.id = id
        self.price = price
        self.estimatedServingTime = estimatedServingTime
        self.warnings = warnings
        self.ingredients = ingredients
        self.image = image.pngData()! // Convert image to raw data
        self.status = status
    }
}
