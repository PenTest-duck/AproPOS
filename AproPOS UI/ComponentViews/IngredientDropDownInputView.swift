//
//  IngredientDropDownInputView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 9/7/22.
//

import SwiftUI
import Combine

struct IngredientDropDownInputView: View {
    @EnvironmentObject var menuVM: MenuViewModel // need EnvironmentObject to refer to same menuVM as MenuView
    @StateObject private var inventoryVM = InventoryViewModel()
    
    @State private var selectedIngredient: String = ""
    @State private var addingIngredient: Bool = false
    @State private var oldIngredient: String = ""
    
    @State private var error: String = ""
    
    static var uniqueKey: String {
        UUID().uuidString
    }

    @State private var options: [DropdownOption] = []
    
    func fillOptions() -> [DropdownOption] {
        var out: [DropdownOption] = []
        for ingredient in inventoryVM.inventory {
            if !menuVM.ingredientsInput.keys.contains(ingredient.id!) {
                out.append(DropdownOption(key: IngredientDropDownInputView.uniqueKey, value: ingredient.id!))
            }
        }
        return out
    }
        
    // let ingredients: [String: Decimal] // TODO: Don't need?
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if !addingIngredient {
                    Rectangle()
                        .foregroundColor(Color(red: 249/255, green: 228/255, blue: 183/255))
                    
                    if menuVM.ingredientsInput.isEmpty {
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
                            ForEach(menuVM.ingredientsInput.sorted(by: <), id: \.key) { name, quantity in
                                ZStack {
                                    Button(action: {
                                        selectedIngredient = name
                                        menuVM.ingredientQuantityInput = String(describing: quantity)
                                        addingIngredient = true
                                    }) {
                                        ZStack {
                                            Rectangle()
                                                .stroke(.blue, lineWidth: 2)
                                                .background(Rectangle().fill(.yellow))
                                                .frame(height: 40)
                                            
                                            Text("\(String(describing: quantity)) \(inventoryVM.unitsOf(name: name)) \(name)")
                                                .font(.system(size: 20))
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Button(action: {
                                            menuVM.ingredientsInput.removeValue(forKey: name)
                                        }) {
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(.red)
                                                .font(.system(size: 28))
                                        }
                                    }.padding(.horizontal, 5)
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
                            placeholder: selectedIngredient == "" ? "Select ingredient" : selectedIngredient,
                            options: options,
                            onOptionSelected: { option in
                                if !selectedIngredient.isEmpty {
                                    oldIngredient = selectedIngredient
                                }
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
                                if menuVM.ingredientQuantityInput == "0" {
                                    error = "Please enter a quantity"
                                } else if menuVM.ingredientQuantityInput.components(separatedBy: ".").count - 1 >= 2 {
                                    error = "Invalid quantity"
                                } else {
                                    if !oldIngredient.isEmpty { // changing ingredient
                                        print("changing ingredient")
                                        menuVM.ingredientsInput.removeValue(forKey: oldIngredient)
                                        oldIngredient = ""
                                    }
                                    menuVM.ingredientsInput[selectedIngredient] = Decimal(Double(menuVM.ingredientQuantityInput)!)
                                    addingIngredient = false
                                    menuVM.ingredientQuantityInput = "0"
                                    selectedIngredient = ""
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
                            }
                            
                            Text("\(error)")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.bottom, 5)
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
                            .font(.system(size: 17))
                    }
                    
                    Button(action: {
                        addingIngredient = false
                    }) {
                        Image(systemName: "gobackward")
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                    }
                }.padding(.horizontal, 15)
            }
        }.onAppear {
            inventoryVM.getInventory()
        }

    }
}

struct IngredientDropDownInputView_Previews: PreviewProvider {
    //var menuVM.ingredientsInput: [String: Decimal] = ["eggs": 5, "bacon": 2]
    //static var sampleIngredients: [String: Decimal] = ["eggs": 5, "bacon": 2]
    
    static var previews: some View {
        IngredientDropDownInputView()//ingredients: sampleIngredients)
            .frame(width: 350, height: 500)
            .environmentObject(MenuViewModel())
    }
}
