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
            menuRepository.addMenuItem(menuItem: newMenuItem)
        }
    }
    
    func editMenuItem() {
        guard let originalMenuItem = menu.first(where: { $0.id == menuItemNameInput }) else {
            print("Menu item doesn't exist")
            return
        }
        
        let editedMenuItemPrice = menuItemPriceInput == 0.00 ? originalMenuItem.price : menuItemPriceInput
        let editedMenuItemEstimatedServingTime = menuItemEstimatedServingTimeInput == 0 ? originalMenuItem.estimatedServingTime : menuItemEstimatedServingTimeInput
        let editedWarnings = menuItemWarningsInput == [] ? originalMenuItem.warnings : menuItemWarningsInput
        let editedIngredients = menuItemIngredientsInput == [:] ? originalMenuItem.ingredients : menuItemIngredientsInput
        let editedImage = menuItemImageInput == UIImage(named: "defaultMenuItemImage") ? UIImage(data: originalMenuItem.image)! : menuItemImageInput
        
        let editedMenuItem = MenuItemModel(id: menuItemNameInput, price: editedMenuItemPrice, estimatedServingTime: editedMenuItemEstimatedServingTime, warnings: editedWarnings, ingredients: editedIngredients, image: editedImage)
        
        menuRepository.addMenuItem(menuItem: editedMenuItem)
    }
    
    func getMenu() {
        menuRepository.fetchMenu() { (fetchedMenu) -> Void in
            self.menu = fetchedMenu
        }
    }

    func removeMenuItem() {
        menuRepository.removeMenuItem(name: menuItemNameInput)
    }
    
    func checkUnavailableMenuItems() {
        menuRepository.checkUnavailableMenuItems()
    }
}
