//
//  IngredientDropDownInputView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 9/7/22.
//

import SwiftUI
import Combine

struct IngredientDropDownInputView: View {
    @StateObject private var menuVM = MenuViewModel()
    @StateObject private var inventoryVM = InventoryViewModel()
    
    @State private var selectedIngredient: String = ""
    @State private var addingIngredient: Bool = false //true //false
    
    static var uniqueKey: String {
        UUID().uuidString
    }

    @State private var options: [DropdownOption] = []
    
    func fillOptions() -> [DropdownOption] {
        var out: [DropdownOption] = []
        for ingredient in inventoryVM.inventory {
            out.append(DropdownOption(key: IngredientDropDownInputView.uniqueKey, value: ingredient.id!))
        }
        return out
    }
        
    let ingredients: [String: Int]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if !addingIngredient {
                    Rectangle()
                        .foregroundColor(Color(red: 249/255, green: 228/255, blue: 183/255))
                    
                    if ingredients.isEmpty {
                        VStack(spacing: 10) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: 50))
                            Text("No ingredients")
                                .font(.system(size: 40))
                                .fontWeight(.semibold)
                            Text("Add ingredients by pressing the plus icon.")
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        VStack(spacing: 0) {
                            ForEach(ingredients.sorted(by: <), id: \.key) { name, quantity in
                                Button(action: {
                                    selectedIngredient = name
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .stroke(.blue, lineWidth: 2)
                                            .background(Rectangle().fill(.yellow))
                                            .frame(height: 40)
                                        
                                        Text("\(quantity) \(inventoryVM.unitsOf(name: name)) \(name)")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                } else if addingIngredient {
                    Rectangle()
                        .foregroundColor(Color(red: 255/255, green: 204/255, blue: 255/255))
                    
                    VStack {
                        Text("Add Ingredient")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        
                        // TODO: Fix dropdown frame
                        
                        DropdownSelector(
                            placeholder: "Select ingredient",
                            options: options,
                            onOptionSelected: { option in
                                selectedIngredient = option.value
                            }
                        ).padding(.horizontal, 20)
                        
                        Spacer()
                        
                        if selectedIngredient != "" {
                            HStack {
                                Text("Quantity:")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 20))
                                
                                Spacer()
                                
                                TextField("", text: $menuVM.ingredientQuantityInput)
                                    .font(.system(size: 20))
                                    .background(.white)
                                    .frame(width: 100, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                                    .onReceive(Just(menuVM.ingredientQuantityInput)) { newValue in
                                        let filtered = newValue.filter { ".0123456789".contains($0) }
                                        if filtered != newValue {
                                            menuVM.ingredientQuantityInput = filtered
                                        }
                                    }
                                
                                Text("\(inventoryVM.unitsOf(name: selectedIngredient))")
                                    .font(.system(size: 20))
                            }.padding(.horizontal, 40)
                            
                            Button(action: {
                                if menuVM.ingredientQuantityInput != "0" {
                                    menuVM.ingredientsInput[selectedIngredient] = Int(menuVM.ingredientQuantityInput)
                                    addingIngredient = false
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(30)
                                        .foregroundColor(Color.blue)
                                        .frame(width: 200, height: 50)
                                        .padding(.bottom, 10)
                                    
                                    Text("Save changes")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 10)
                                        .font(.system(size: 25))
                                }
                            }.padding(.bottom, 5)
                        }
                    }.padding(.top, 30)
                    .onAppear {
                        options = fillOptions()
                    }
                }
            }
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 194/255, green: 194/255, blue: 250/255))
                    .frame(height: 30)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        selectedIngredient = ""
                        addingIngredient = true
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.white)
                    }
                }.padding(.horizontal, 15)
            }
        }
        .onAppear {
            inventoryVM.getInventory() // for unitsOf()
        }
    }
}

struct IngredientDropDownInputView_Previews: PreviewProvider {
    static var sampleIngredients: [String: Int] = ["eggs": 5, "bacon": 2]
    
    static var previews: some View {
        IngredientDropDownInputView(ingredients: sampleIngredients)
            .frame(width: 350, height: 500)
    }
}
