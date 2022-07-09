//
//  IngredientDropDownInputView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 9/7/22.
//

import SwiftUI

struct IngredientDropDownInputView: View {
    @StateObject private var menuVM = MenuViewModel()
    @StateObject private var inventoryVM = InventoryViewModel()
    
    let ingredients: [String: Int]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 249/255, green: 228/255, blue: 183/255))
                
                VStack {
                    ForEach(ingredients.sorted(by: <), id: \.key) { name, quantity in
                        Text("\(quantity) \(inventoryVM.unitsOf(name: name)) \(name)")
                    }
                }
            }
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 194/255, green: 194/255, blue: 250/255))
                    .frame(height: 30)
                
                HStack {
                    Spacer()
                    Image(systemName: "plus.circle")
                        .foregroundColor(.white)
                    Image(systemName: "minus.circle")
                        .foregroundColor(.white)
                }.padding(.horizontal, 15)
            }
        }
    }
}

struct IngredientDropDownInputView_Previews: PreviewProvider {
    static var sampleIngredients = ["eggs": 5, "bacon": 2]
    
    static var previews: some View {
        IngredientDropDownInputView(ingredients: sampleIngredients)
            .frame(width: 350, height: 500)
    }
}
