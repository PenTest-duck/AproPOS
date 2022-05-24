//
//  MenuItemModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation

struct MenuItemModel: Identifiable {
    var id: String
    var name: String
    
    var price: Decimal
    var ingredients: [[String: Int]]
    //var image: UIImage
}
