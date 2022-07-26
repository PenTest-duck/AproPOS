//
//  InventoryViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation
import SwiftUI // only for Color

final class InventoryViewModel: ObservableObject {
    // Repository and storage
    @Published var inventory = [IngredientModel]()
    @Published var inventoryRepository = InventoryRepository()
    
    // Error field
    @Published var error = ""

    // Input fields
    @Published var nameInput: String = ""
    @Published var unitsInput: String = ""
    @Published var currentStockInput: String = "0" // Decimal = 0
    @Published var minimumThresholdInput: String = "0" // Decimal = 0
    @Published var costPerUnitInput: String = "0.00" // Decimal = 0.00
    @Published var warningsInput: [String] = []
    @Published var commentInput: String = ""
    
    // Input field for editing ingredient name
    @Published var newNameInput: String = ""
    
    // Validates input fields
    func validateInput(operation: String) {
        if operation == "add" && nameInput == "" { // Check if name is empty when adding ingredient
            error = "Please enter a name"
        } else if operation == "add" && inventory.firstIndex(where: { $0.id == nameInput }) != nil { // Check if ingredient already exists when adding ingredient
            error = "Ingredient already exists in inventory"
        } else if (currentStockInput.filter { $0 == "." }).count >= 2 { // Check if current stock contains more than one decimal point
            error = "Invalid current stock"
        } else if (minimumThresholdInput.filter { $0 == "." }).count >= 2 { // Check if minimum threshold contains more than one decimal point
            error = "Invalid minimum threshold"
        } else if (costPerUnitInput.filter { $0 == "." }).count >= 2 { // Check if cost per unit contains more than one decimal point
            error = "Invalid cost per unit"
        } else if costPerUnitInput[(costPerUnitInput.firstIndex(of: ".") ?? costPerUnitInput.index(costPerUnitInput.endIndex, offsetBy: -1))...].count > 3 { // Check if currency contains more than two decimal digits
            error = "Currency allows max. 2 decimal places"
        } else {
            error = ""
        }
    }
    
    // Retrieves all ingredients and stores them in inventory
    // Can be run once, and will asynchronously update if there are changes to the database
    func getInventory() {
        inventoryRepository.fetchInventory() { (fetchedInventory) -> Void in // Awaits until completion of fetchInventory()
            self.inventory = fetchedInventory
        }
    }
    
    // Adds a new ingredient to the database, by first validating the input
    func addIngredient() {
        validateInput(operation: "add")
        
        if error == "" {
            // Create new IngredientModel
            let newIngredient = IngredientModel(id: nameInput, units: unitsInput, currentStock: Decimal(Double(currentStockInput)!), minimumThreshold: Decimal(Double(minimumThresholdInput)!), costPerUnit: Decimal(Double(costPerUnitInput)!), warnings: warningsInput, comment: commentInput)
            
            // Add to database
            inventoryRepository.addIngredient(ingredient: newIngredient)
        }
    }
    
    // Edits an existing ingredient
    func editIngredient() {
        // Check if ingredient exists
        guard let originalIngredient = inventory.first(where: { $0.id == nameInput }) else {
            print("Ingredient doesn't exist")
            return
        }
        
        validateInput(operation: "edit")
        
        if error == "" {
            // Check if an input is empty, retain the original value if it is, and use the new value if it isn't
            let editedUnits = unitsInput == "" ? originalIngredient.units : unitsInput
            let editedCurrentStock = currentStockInput == "0" ? originalIngredient.currentStock : Decimal(Double(currentStockInput)!)
            let editedMinimumThreshold = minimumThresholdInput == "0" ? originalIngredient.minimumThreshold : Decimal(Double(minimumThresholdInput)!)
            let editedCostPerUnit = costPerUnitInput == "0.00" ? originalIngredient.costPerUnit : Decimal(Double(costPerUnitInput)!)
            let editedWarnings = warningsInput == [] ? originalIngredient.warnings : warningsInput
            let editedComment = commentInput == "" ? originalIngredient.comment : commentInput
            
            // Create a new IngredientModel with updated data
            let editedIngredient = IngredientModel(id: nameInput, units: editedUnits, currentStock: editedCurrentStock, minimumThreshold: editedMinimumThreshold, costPerUnit: editedCostPerUnit, warnings: editedWarnings, comment: editedComment)
            
            inventoryRepository.addIngredient(ingredient: editedIngredient)
        }
    }
    
    // Edits the name of an existing ingredient
    func editIngredientName() {
        if inventory.firstIndex(where: { $0.id == newNameInput }) != nil { // Check if ingredient with name already exists
            error = "Ingredient already exists"
        } else {
            // Retrieve the existing ingredient
            let existingIngredient = inventory.first(where: { $0.id == nameInput } )

            // Save all non-ID data of existing table into variables
            let existingUnits = existingIngredient!.units
            let existingCurrentStock = existingIngredient!.currentStock
            let existingMinimumThreshold = existingIngredient!.minimumThreshold
            let existingCostPerUnit = existingIngredient!.costPerUnit
            let existingWarnings = existingIngredient!.warnings
            let existingComment = existingIngredient!.comment
            let existingStatus = existingIngredient!.status

            // Create a new ingredient with the saved data, and new name as the ID
            let editedIngredient = IngredientModel(id: newNameInput, units: existingUnits, currentStock: existingCurrentStock, minimumThreshold: existingMinimumThreshold, costPerUnit: existingCostPerUnit, warnings: existingWarnings, comment: existingComment, status: existingStatus)
            inventoryRepository.addIngredient(ingredient: editedIngredient)
            
            // Remove the original ingredient
            inventoryRepository.removeIngredient(name: nameInput)
            error = ""
        }
    }
    
    // Removes an existing ingredient
    func removeIngredient() {
        inventoryRepository.removeIngredient(name: nameInput)
    }
    
    // Provides colours for IndividualIngredientView based on ingredient status
    func ingredientColor(status: String) -> Color {
        switch status {
            case "unavailable": return Color.gray
            case "low": return Color.orange
            case "available": return Color.green
            default: return Color.gray
        }
    }
    
    // Provides measurement units for IngredientDropDownInputView
    func unitsOf(name: String) -> String {
        let ingredient = inventory.first(where: { $0.id == name } )
        return ingredient?.units ?? ""
    }
}
