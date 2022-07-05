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
    @Published var ingredientUnitInput: String = ""
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
            let newIngredient = IngredientModel(id: ingredientNameInput, units: ingredientUnitInput, currentStock: ingredientCurrentStockInput, minimumThreshold: ingredientMinimumThresholdInput, costPerUnit: ingredientCostPerUnitInput, warnings: ingredientWarningsInput, comment: ingredientCommentInput)
            message = inventoryRepository.addIngredient(ingredient: newIngredient)
        }
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
