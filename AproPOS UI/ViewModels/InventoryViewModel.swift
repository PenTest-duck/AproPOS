//
//  InventoryViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation
import SwiftUI // for Color
//import FirebaseFirestoreSwift

final class InventoryViewModel: ObservableObject {
    @Published var inventory = [IngredientModel]()
    @Published var inventoryRepository = InventoryRepository()
    
    @Published var error = ""

    @Published var nameInput: String = ""
    @Published var unitsInput: String = ""
    @Published var currentStockInput: String = "0" // Decimal = 0
    @Published var minimumThresholdInput: String = "0" // Decimal = 0
    @Published var costPerUnitInput: String = "0.00" // Decimal = 0.00
    @Published var warningsInput: [String] = []
    @Published var commentInput: String = ""
    @Published var newNameInput: String = ""
    
    func validateInput(operation: String) {
        if operation == "add" && nameInput == "" {
            error = "Please enter a name"
        } else if operation == "add" && inventory.firstIndex(where: { $0.id == nameInput }) != nil {
            error = "Ingredient already exists in inventory"
        } else if unitsInput.hasPrefix("0") || unitsInput.hasPrefix(".") {
            error = "Invalid units"
        } else if currentStockInput.hasPrefix(".") || (currentStockInput.filter { $0 == "." }).count >= 2 {
            error = "Invalid current stock"
        } else if minimumThresholdInput.hasPrefix(".") || (minimumThresholdInput.filter { $0 == "." }).count >= 2 {
            error = "Invalid minimum threshold"
        } else if costPerUnitInput.hasPrefix(".") || (costPerUnitInput.filter { $0 == "." }).count >= 2 {
            error = "Invalid cost per unit"
        } else if costPerUnitInput[(costPerUnitInput.firstIndex(of: ".") ?? costPerUnitInput.index(costPerUnitInput.endIndex, offsetBy: -1))...].count > 3 {
            error = "Currency allows max. 2 decimal places"
        } else {
            error = ""
        }
    }
    
    func addIngredient() {
        // TODO: units length
        
        validateInput(operation: "add")
        if error == "" {
            let newIngredient = IngredientModel(id: nameInput, units: unitsInput, currentStock: Decimal(Double(currentStockInput)!), minimumThreshold: Decimal(Double(minimumThresholdInput)!), costPerUnit: Decimal(Double(costPerUnitInput)!), warnings: warningsInput, comment: commentInput)
            inventoryRepository.addIngredient(ingredient: newIngredient)
            error = ""
        }
    }
    
    func editIngredient() {
        guard let originalIngredient = inventory.first(where: { $0.id == nameInput }) else {
            print("Ingredient doesn't exist")
            return
        }
        
        validateInput(operation: "edit")
        if error == "" {
            let editedUnits = unitsInput == "" ? originalIngredient.units : unitsInput
            let editedCurrentStock = currentStockInput == "0" ? originalIngredient.currentStock : Decimal(Double(currentStockInput)!)
            let editedMinimumThreshold = minimumThresholdInput == "0" ? originalIngredient.minimumThreshold : Decimal(Double(minimumThresholdInput)!)
            let editedCostPerUnit = costPerUnitInput == "0.00" ? originalIngredient.costPerUnit : Decimal(Double(costPerUnitInput)!)
            let editedWarnings = warningsInput == [] ? originalIngredient.warnings : warningsInput
            let editedComment = commentInput == "" ? originalIngredient.comment : commentInput
            let editedIngredient = IngredientModel(id: nameInput, units: editedUnits, currentStock: editedCurrentStock, minimumThreshold: editedMinimumThreshold, costPerUnit: editedCostPerUnit, warnings: editedWarnings, comment: editedComment)
            inventoryRepository.addIngredient(ingredient: editedIngredient)
            error = ""
        }
    }
    
    func editIngredientName() {
        if inventory.firstIndex(where: { $0.id == newNameInput }) != nil {
            error = "Ingredient already exists"
        } else {
            let existingIngredient = inventory.first(where: { $0.id == nameInput } )

            let existingUnits = existingIngredient!.units
            let existingCurrentStock = existingIngredient!.currentStock
            let existingMinimumThreshold = existingIngredient!.minimumThreshold
            let existingCostPerUnit = existingIngredient!.costPerUnit
            let existingWarnings = existingIngredient!.warnings
            let existingComment = existingIngredient!.comment
            let existingStatus = existingIngredient!.status

            let editedIngredient = IngredientModel(id: newNameInput, units: existingUnits, currentStock: existingCurrentStock, minimumThreshold: existingMinimumThreshold, costPerUnit: existingCostPerUnit, warnings: existingWarnings, comment: existingComment, status: existingStatus)
            inventoryRepository.addIngredient(ingredient: editedIngredient)
            
            inventoryRepository.removeIngredient(name: nameInput)
            error = ""
        }
    }
    
    func getInventory() {
        inventoryRepository.fetchInventory() { (fetchedInventory) -> Void in
            self.inventory = fetchedInventory
        }
    }
    
    func removeIngredient() {
        inventoryRepository.removeIngredient(name: nameInput)
    }
    
    func ingredientColor(status: String) -> Color {
        switch status {
            case "unavailable": return Color.gray
            case "low": return Color.orange
            case "available": return Color.green
            default: return Color.gray
        }
    }
    
    func unitsOf(name: String) -> String {
        let ingredient = inventory.first(where: { $0.id == name } )
        return ingredient?.units ?? ""
    }
}
