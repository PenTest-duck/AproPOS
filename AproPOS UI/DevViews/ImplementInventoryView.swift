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
            Text("Message: \(inventoryVM.error)")
            
            TextField(" Name", text: $inventoryVM.nameInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            TextField(" Units", text: $inventoryVM.unitsInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            Button(action: {
                inventoryVM.addIngredient()
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
            
            Button(action: {
                inventoryVM.editIngredient()
            }) {
                Text("Edit")
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
