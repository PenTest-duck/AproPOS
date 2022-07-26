//
//  MenuViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation
import UIKit // only for UIImage
import FirebaseFirestore
import FirebaseFirestoreSwift

final class MenuViewModel: ObservableObject {
    // Repository and storage
    @Published var menu = [MenuItemModel]()
    @Published var menuRepository = MenuRepository()
    
    // Error field
    @Published var error = ""
    
    // Input fields
    @Published var nameInput: String = ""
    @Published var priceInput: String = "0.00" // Decimal = 0.00
    @Published var ESTInput: String = "0" // Int = 0
    @Published var warningsInput: [String] = []
    @Published var ingredientsInput: [String: Decimal] = [:]
    @Published var imageInput: UIImage = UIImage(named: "defaultMenuItemImage")!
    
    // Input field for editing menu item name
    @Published var newNameInput: String = ""
    
    // Ingredient quantity input field for IngredientDropDownInputView
    @Published var ingredientQuantityInput: String = "0"
    
    // Validates input fields
    func validateInput(operation: String) {
        if operation == "add" && nameInput == "" { // Check if name is empty when adding menu item
            error = "Please enter a name"
        } else if operation == "add" && menu.firstIndex(where: { $0.id == nameInput }) != nil { // Check if menu item already exists when adding menu item
            error = "Item already exists in menu"
        } else if operation == "add" && Double(priceInput) == 0 { // Check if price is zero when adding menu item
            error = "Please enter a price"
        } else if (priceInput.filter { $0 == "." }).count >= 2 { // Check if price contains more than one decimal point
            error = "Invalid price"
        } else if priceInput[(priceInput.firstIndex(of: ".") ?? priceInput.index(priceInput.endIndex, offsetBy: -1))...].count > 3 { // Check if price contains more than two decimal digits
            error = "Currency allows max. 2 decimal places"
        } else if ingredientsInput == [:] { // Check if ingredients are empty
            error = "Please add at least 1 ingredient"
        } else if imageInput.pngData()!.count > 900 * 1024 { // Check if menu item image exceeds 900KB - Firestore allows max. 1MB documentsin the free plan, so leave 100KB extra for other data
            error = "Image must be smaller than 900KB."
        } else {
            error = ""
        }
    }
    
    // Retrieves all menu items and stores them in menu
    // Can be run once, and will asynchronously update if there are changes to the database
    func getMenu() {
        menuRepository.fetchMenu() { (fetchedMenu) -> Void in
            self.menu = fetchedMenu
        }
    }
    
    // Adds a new menu item to the database, by first validating the input
    func addMenuItem() { 
        validateInput(operation: "add")
        
        if error == "" {
            // Create new MenuItemModel
            let newMenuItem = MenuItemModel(id: nameInput, price: Decimal(Double(priceInput)!), estimatedServingTime: Int(ESTInput)!, warnings: warningsInput, ingredients: ingredientsInput, image: imageInput)
            
            // Add to database
            menuRepository.addMenuItem(menuItem: newMenuItem)
        }
    }
    
    // Edits an existing menu item
    func editMenuItem() {
        // Check if menu item exists
        guard let originalMenuItem = menu.first(where: { $0.id == nameInput }) else {
            print("Menu item doesn't exist")
            return
        }
        
        validateInput(operation: "edit")
        
        if error == "" {
            // Check if an input is empty, retain the original value if it is, and use the new value if it isn't
            let editedPrice = priceInput == "0.00" ? originalMenuItem.price : Decimal(Double(priceInput)!)
            let editedEST = ESTInput == "0" ? originalMenuItem.estimatedServingTime : Int(ESTInput)!
            let editedWarnings = warningsInput == [] ? originalMenuItem.warnings : warningsInput
            let editedIngredients = ingredientsInput == [:] ? originalMenuItem.ingredients : ingredientsInput
            let editedImage = imageInput == UIImage(named: "defaultMenuItemImage") ? UIImage(data: originalMenuItem.image)! : imageInput
            
            // Create a new MenuItemModel with updated data
            let editedMenuItem = MenuItemModel(id: nameInput, price: editedPrice, estimatedServingTime: editedEST, warnings: editedWarnings, ingredients: editedIngredients, image: editedImage)
            
            menuRepository.addMenuItem(menuItem: editedMenuItem)
        }
    }
    
    // Edits the name of an existing menu item
    func editMenuItemName() {
        if menu.firstIndex(where: { $0.id == newNameInput }) != nil { // Check if menu item with name already exists
            error = "Menu item already exists"
        } else {
            // Retrives the existing menu item
            let existingMenuItem = menu.first(where: { $0.id == nameInput } )

            // Save all non-ID data of existing table into variables
            let existingPrice = existingMenuItem!.price
            let existingEST = existingMenuItem!.estimatedServingTime
            let existingWarnings = existingMenuItem!.warnings
            let existingIngredients = existingMenuItem!.ingredients
            let existingImage = UIImage(data: existingMenuItem!.image)!
            let existingStatus = existingMenuItem!.status

            // Create a new menu item with the saved data, and new name as the ID
            let editedMenuItem = MenuItemModel(id: newNameInput, price: existingPrice, estimatedServingTime: existingEST, warnings: existingWarnings, ingredients: existingIngredients, image: existingImage, status: existingStatus)
            menuRepository.addMenuItem(menuItem: editedMenuItem)
            
            // Remove the original menu item
            menuRepository.removeMenuItem(name: nameInput)
            error = ""
        }
    }

    // Removes an existing menu item
    func removeMenuItem() {
        menuRepository.removeMenuItem(name: nameInput)
    }
    
    // Monitors ingredient stock levels and updates menu item statuses
    // Can be run once, and will asynchronously update if there are changes to the database
    func checkUnavailableMenuItems() {
        menuRepository.checkUnavailableMenuItems()
    }
}
