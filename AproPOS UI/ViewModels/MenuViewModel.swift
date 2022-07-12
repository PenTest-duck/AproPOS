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
    
    @Published var error = ""
    
    @Published var nameInput: String = ""
    @Published var priceInput: String = "0.00" // Decimal = 0.00
    @Published var ESTInput: String = "0" // Int = 0
    @Published var warningsInput: [String] = []
    @Published var ingredientsInput: [String: Decimal] = [:]
    @Published var imageInput: UIImage = UIImage(named: "defaultMenuItemImage")!
    @Published var newNameInput: String = ""
    
    @Published var ingredientQuantityInput: String = "0"
    
    func validateInput(operation: String) {
        //print(ingredientsInput)
        if operation == "add" && nameInput == "" {
            error = "Please enter a name"
        } else if operation == "add" && menu.firstIndex(where: { $0.id == nameInput }) != nil {
            error = "Item already exists in menu"
        } else if operation == "add" && Double(priceInput) == 0 {
            error = "Please enter a price"
        } else if priceInput.hasPrefix(".") || (priceInput.filter { $0 == "." }).count >= 2 {
            error = "Invalid price"
        } else if priceInput[(priceInput.firstIndex(of: ".") ?? priceInput.index(priceInput.endIndex, offsetBy: -1))...].count > 3 {
            error = "Currency allows max. 2 decimal places"
        } else if ingredientsInput == [:] {
            error = "Please add at least 1 ingredient"
        }
        else {
            error = ""
        }
    }
    
    func addMenuItem() { 
        validateInput(operation: "add")
        if error == "" {
            let newMenuItem = MenuItemModel(id: nameInput, price: Decimal(Double(priceInput)!), estimatedServingTime: Int(ESTInput)!, warnings: warningsInput, ingredients: ingredientsInput, image: imageInput)
            menuRepository.addMenuItem(menuItem: newMenuItem)
            error = ""
        }
    }
    
    func editMenuItem() {
        guard let originalMenuItem = menu.first(where: { $0.id == nameInput }) else {
            print("Menu item doesn't exist")
            return
        }
        
        validateInput(operation: "edit")
        if error == "" {
            let editedPrice = priceInput == "0.00" ? originalMenuItem.price : Decimal(Double(priceInput)!)
            let editedEST = ESTInput == "0" ? originalMenuItem.estimatedServingTime : Int(ESTInput)!
            let editedWarnings = warningsInput == [] ? originalMenuItem.warnings : warningsInput
            let editedIngredients = ingredientsInput == [:] ? originalMenuItem.ingredients : ingredientsInput
            let editedImage = imageInput == UIImage(named: "defaultMenuItemImage") ? UIImage(data: originalMenuItem.image)! : imageInput
            
            let editedMenuItem = MenuItemModel(id: nameInput, price: editedPrice, estimatedServingTime: editedEST, warnings: editedWarnings, ingredients: editedIngredients, image: editedImage)
            
            menuRepository.addMenuItem(menuItem: editedMenuItem)
        }
    }
    
    func editMenuItemName() {
        if menu.firstIndex(where: { $0.id == newNameInput }) != nil {
            error = "Menu item already exists"
        } else {
            let existingMenuItem = menu.first(where: { $0.id == nameInput } )

            let existingPrice = existingMenuItem!.price
            let existingEST = existingMenuItem!.estimatedServingTime
            let existingWarnings = existingMenuItem!.warnings
            let existingIngredients = existingMenuItem!.ingredients
            let existingImage = UIImage(data: existingMenuItem!.image)!
            let existingStatus = existingMenuItem!.status

            let editedMenuItem = MenuItemModel(id: newNameInput, price: existingPrice, estimatedServingTime: existingEST, warnings: existingWarnings, ingredients: existingIngredients, image: existingImage, status: existingStatus)
            menuRepository.addMenuItem(menuItem: editedMenuItem)
            
            menuRepository.removeMenuItem(name: nameInput)
            error = ""
        }
    }
    
    func getMenu() {
        menuRepository.fetchMenu() { (fetchedMenu) -> Void in
            self.menu = fetchedMenu
        }
    }

    func removeMenuItem() {
        menuRepository.removeMenuItem(name: nameInput)
    }
    
    func checkUnavailableMenuItems() {
        menuRepository.checkUnavailableMenuItems()
    }
}
