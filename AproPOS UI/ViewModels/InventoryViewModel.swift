//
//  InventoryViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation
//import FirebaseFirestoreSwift

final class InventoryViewModel: ObservableObject {
    @Published var inventory = [IngredientModel]()
    @Published var inventoryRepository = InventoryRepository()
    
    @Published var message = ""

    @Published var ingredientNameInput: String = ""
    @Published var ingredientUnitsInput: String = ""
    @Published var ingredientCurrentStockInput: Decimal = 0
    @Published var ingredientMinimumThresholdInput: Decimal = 0
    @Published var ingredientCostPerUnitInput: Decimal = 0.00
    @Published var ingredientWarningsInput: [String] = []
    @Published var ingredientCommentInput: String = ""
    
    func addIngredient() {
        if ingredientNameInput == "" {
            message = "Please enter a name"
        } else if inventory.firstIndex(where: { $0.id == ingredientNameInput }) != nil {
            message = "Ingredient already exists in inventory"
        } else {
            let newIngredient = IngredientModel(id: ingredientNameInput, units: ingredientUnitsInput, currentStock: ingredientCurrentStockInput, minimumThreshold: ingredientMinimumThresholdInput, costPerUnit: ingredientCostPerUnitInput, warnings: ingredientWarningsInput, comment: ingredientCommentInput)
            inventoryRepository.addIngredient(ingredient: newIngredient)
        }
    }
    
    func editIngredient() {
        guard let originalIngredient = inventory.first(where: { $0.id == ingredientNameInput }) else {
            print("Ingredient doesn't exist")
            return
        }
        
        let editedUnits = ingredientUnitsInput == "" ? originalIngredient.units : ingredientUnitsInput
        let editedCurrentStock = ingredientCurrentStockInput == 0 ? originalIngredient.currentStock : ingredientCurrentStockInput
        let editedMinimumThreshold = ingredientMinimumThresholdInput == 0 ? originalIngredient.minimumThreshold : ingredientMinimumThresholdInput
        let editedCostPerUnit = ingredientCostPerUnitInput == 0 ? originalIngredient.costPerUnit : ingredientCostPerUnitInput
        let editedWarnings = ingredientWarningsInput == [] ? originalIngredient.warnings : ingredientWarningsInput
        let editedComment = ingredientCommentInput == "" ? originalIngredient.comment : ingredientCommentInput
        let editedIngredient = IngredientModel(id: ingredientNameInput, units: editedUnits, currentStock: editedCurrentStock, minimumThreshold: editedMinimumThreshold, costPerUnit: editedCostPerUnit, warnings: editedWarnings, comment: editedComment)
        
        inventoryRepository.addIngredient(ingredient: editedIngredient)
    }
    
    func getInventory() {
        inventoryRepository.fetchInventory() { (fetchedInventory) -> Void in
            self.inventory = fetchedInventory
        }
    }
    
    func removeIngredient() {
        inventoryRepository.removeIngredient(name: ingredientNameInput)
    }
    
}
