//
//  ImplementInventoryView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import SwiftUI

struct ImplementInventoryView: View {
    
    @StateObject private var inventoryVM = InventoryViewModel()
    
    var body: some View {
        VStack {
            Text("Message: \(inventoryVM.message)")
            
            TextField(" Name", text: $inventoryVM.ingredientNameInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            Button(action: {
                inventoryVM.getInventory()
                //testIngredient()
                inventoryVM.addIngredient()
                inventoryVM.getInventory()
            }) {
                Text("Add Ingredient")
            }
            
            Button(action: {
                inventoryVM.getInventory()
            }) {
                Text("Get Inventory")
            }
            
            Button(action: {
                inventoryVM.removeIngredient()
            }) {
                Text("Remove")
            }
        }
        .onAppear {
            inventoryVM.getInventory()
        }
    }
}

struct ImplementInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        ImplementInventoryView().previewInterfaceOrientation(.landscapeLeft)
    }
}
