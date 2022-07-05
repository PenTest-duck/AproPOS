//
//  MenuViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation
import UIKit // for UIImage
import FirebaseFirestore
import FirebaseFirestoreSwift

final class MenuViewModel: ObservableObject {
    @Published var menu = [MenuItemModel]()
    @Published var menuRepository = MenuRepository()
    
    @Published var message = ""
    
    @Published var menuItemNameInput: String = ""
    @Published var menuItemPriceInput: Decimal = 0.00
    @Published var menuItemEstimatedServingTimeInput: Int = 0
    @Published var menuItemWarningsInput: [String] = []
    @Published var menuItemIngredientsInput: [String: Int] = [:]
    @Published var menuItemImageInput: UIImage = UIImage(named: "defaultMenuItemImage")!
    
    func addMenuItem() { 
        if menuItemNameInput == "" {
            message = "Please enter a name"
        } else if menuItemPriceInput == 0.00 {
            message = "Please enter a price"
        } else if menuItemEstimatedServingTimeInput == 0 {
            message = "Please enter an estimated serving time"
        } else if menu.firstIndex(where: { $0.id == menuItemNameInput }) != nil {
            message = "Menu item already exists"
        } else {
            let newMenuItem = MenuItemModel(id: menuItemNameInput, price: menuItemPriceInput, estimatedServingTime: menuItemEstimatedServingTimeInput, warnings: menuItemWarningsInput, ingredients: menuItemIngredientsInput, image: menuItemImageInput)
            message = menuRepository.addMenuItem(menuItem: newMenuItem)
        }
    }
    
    func getMenu() {
        menu = menuRepository.fetchMenu() // first time it doesn't fill it up?
        print(menu) // for debugging
    }
    
    func editMenuItem() { // should be the same logic as addMenuItem() without checking for already existing menu items
        if menuItemNameInput == "" {
            message = "Please enter a name"
        } else if menuItemPriceInput == 0.00 {
            message = "Please enter a price"
        } else if menuItemEstimatedServingTimeInput == 0 {
            message = "Please enter an estimated serving time"
        } else {
            let newMenuItem = MenuItemModel(id: menuItemNameInput, price: menuItemPriceInput, estimatedServingTime: menuItemEstimatedServingTimeInput, warnings: menuItemWarningsInput, ingredients: menuItemIngredientsInput, image: menuItemImageInput)
            message = menuRepository.addMenuItem(menuItem: newMenuItem)
        }
    }
    
    func removeMenuItem() {
        menuRepository.removeMenuItem(name: menuItemNameInput)
    }
    
    func checkUnavailableMenuItems() {
        menuRepository.checkUnavailableMenuItems()
    }
}
