//
//  IndividualIngredientView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 7/7/22.
//

import SwiftUI

struct IndividualIngredientView: View {
    @StateObject private var inventoryVM = InventoryViewModel()
    
    let ingredient: IngredientModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(inventoryVM.ingredientColor(status: ingredient.status))
            
            VStack {
                ZStack {
                    HStack {
                        Text("\(ingredient.id!)")
                        .font(.title)
                        .fontWeight(.bold)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("\(String(describing: ingredient.currentStock)) \(ingredient.units)  /   \(String(describing: ingredient.minimumThreshold)) \(ingredient.units)")
                            .font(.title)
                            .foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255))
                            .padding()
                    }.padding(.trailing, 25)
                }
            }
        }
    }
}

struct IndividualIngredientView_Previews: PreviewProvider {
    static var sampleIngredient = IngredientModel(id: "Bacon", units: "kg", currentStock: Decimal(3.1415), minimumThreshold: 5, costPerUnit: 8.5, warnings: ["meat", "frozen"], comment: "Pig is good", status: "low")
    
    static var previews: some View {
        IndividualIngredientView(ingredient: sampleIngredient)
            .frame(width: 600, height: 40)
    }
}
