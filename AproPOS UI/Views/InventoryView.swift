//
//  InventoryView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 8/7/22.
//

import SwiftUI
import Combine

struct InventoryView: View {
    @StateObject private var inventoryVM = InventoryViewModel()
    
    @State private var selectedIngredient: IngredientModel? = nil
    @State private var addingIngredient: Bool = false
    @State private var confirmingDelete: Bool = false
    @State private var editingIngredientName: Bool = false
    
    //@FocusState private var isFocused: Bool
    
    static var uniqueKey: String {
        UUID().uuidString
    }

    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "free"),
        DropdownOption(key: uniqueKey, value: "yetToOrder"),
        DropdownOption(key: uniqueKey, value: "ordered"),
        DropdownOption(key: uniqueKey, value: "eating"),
        DropdownOption(key: uniqueKey, value: "cleaning"),
        DropdownOption(key: uniqueKey, value: "reserved"),
        DropdownOption(key: uniqueKey, value: "unavailable")
    ]
    
    var body: some View {
        if !confirmingDelete && !editingIngredientName {
            HStack (spacing: 0) {
                VStack {
                    VStack {
                        ZStack {
                            HStack {
                                Text("Inventory")
                                    .font(.system(size: 55))
                                    .fontWeight(.bold)
                            }
                                
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    addingIngredient = true
                                    inventoryVM.error = ""
                                    inventoryVM.nameInput = ""
                                    inventoryVM.unitsInput = ""
                                    inventoryVM.currentStockInput = "0" // 0
                                    inventoryVM.minimumThresholdInput = "0" // 0
                                    inventoryVM.costPerUnitInput = "0.00" // 0.00
                                    inventoryVM.warningsInput = []
                                    inventoryVM.commentInput = ""
                                }) {
                                    Image(systemName: "plus.square.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.green)
                                }
                                .padding(.trailing, 10)
                            }
                            Spacer()
                        }
                    }
                    
                    ZStack {
                        if inventoryVM.inventory == [] {
                            VStack(spacing: 10) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 50))
                                Text("No ingredients")
                                    .font(.system(size: 50))
                                    .fontWeight(.semibold)
                                Text("Create your first ingredient by pressing the add icon.")
                                    .font(.system(size: 20))
                            }.padding(.bottom, 90)
                        }
                        
                        List {
                            ForEach(inventoryVM.inventory) { ingredient in
                                Button(action: {
                                    addingIngredient = false
                                    inventoryVM.error = ""
                                    selectedIngredient = ingredient
                                    inventoryVM.unitsInput = selectedIngredient!.units
                                    inventoryVM.currentStockInput = String(describing: selectedIngredient!.currentStock)
                                    inventoryVM.minimumThresholdInput = String(describing: selectedIngredient!.minimumThreshold)
                                    inventoryVM.costPerUnitInput = String(describing: selectedIngredient!.costPerUnit)
                                    inventoryVM.warningsInput = selectedIngredient!.warnings
                                    inventoryVM.commentInput = selectedIngredient!.comment
                                }) {
                                    IndividualIngredientView(ingredient: ingredient)
                                }.listRowBackground(Color(red: 242/255, green: 242/255, blue: 248/255))
                            }
                        }.listStyle(PlainListStyle())
                    }
                    
                }
                
                Spacer()
                
                Divider()
                    .frame(width: 10)
                    .background(.red)
                
                ZStack {
                    VStack {
                        if addingIngredient {
                            Group {
                                Text("New")
                                    .font(Font.custom("DIN Bold", size: 60))
                                
                                Text("Ingredient")
                                    .font(Font.custom("DIN Bold", size: 60))
                            }
                            
                            HStack {
                                Text("Name")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $inventoryVM.nameInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 300, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Units")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $inventoryVM.unitsInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 150, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Current Stock")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $inventoryVM.currentStockInput)
                                    .background(.white)
                                    .frame(width: 150, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                                    .onReceive(Just(inventoryVM.currentStockInput)) { newValue in
                                        let filtered = newValue.filter { ".0123456789".contains($0) }
                                        if filtered != newValue {
                                            inventoryVM.currentStockInput = filtered
                                        }
                                    }
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Min. Threshold")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $inventoryVM.minimumThresholdInput)
                                    .background(.white)
                                    .frame(width: 150, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                                    .onReceive(Just(inventoryVM.minimumThresholdInput)) { newValue in
                                        let filtered = newValue.filter { ".0123456789".contains($0) }
                                        if filtered != newValue {
                                            inventoryVM.minimumThresholdInput = filtered
                                        }
                                    }
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Cost Per Unit")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Text("$")
                                TextField("", text: $inventoryVM.costPerUnitInput)
                                    .background(.white)
                                    .frame(width: 120, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                                    .onReceive(Just(inventoryVM.costPerUnitInput)) { newValue in
                                        let filtered = newValue.filter { ".0123456789".contains($0) }
                                        if filtered != newValue {
                                            inventoryVM.costPerUnitInput = filtered
                                        }
                                    }
                            }.padding(.horizontal, 20)
                            
                            // TODO: Warnings
                            
                            VStack {
                                Text("Comment")
                                    .fontWeight(.bold)
                                
                                TextEditor(text: $inventoryVM.commentInput)
                                    .foregroundColor(.black)
                                    .font(.system(size: 25))
                                    .background(.white)
                                    .frame(height: 200)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.leading)
                                    
                            }.padding(.horizontal, 20)
                                .padding(.bottom, 10)
                            
                            Spacer()
                            
                            Button(action: {
                                inventoryVM.addIngredient()
                                if inventoryVM.error == "" {
                                    self.selectedIngredient = nil
                                    addingIngredient = false
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(30)
                                        .foregroundColor(Color.blue)
                                        .frame(width: 380, height: 100)
                                        .padding(.bottom, 10)
                                    
                                    Text("Add Ingredient")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 10)
                                        .font(.system(size: 35))
                                }
                            }
                            
                            Text("\(inventoryVM.error)")
                                .foregroundColor(.red)
                                .font(.system(size: 22))
                                .frame(maxWidth: 380)
                            
                        } else if let selectedIngredient = selectedIngredient {
                            Text("\(selectedIngredient.id!)")
                                .font(Font.custom("DIN Bold", size: 60))
                            
                            Button(action: {
                                editingIngredientName = true
                            }) {
                                HStack {
                                    Image(systemName: "pencil.tip.crop.circle")
                                    Text("Edit Ingredient Name")
                                }.font(.system(size: 20))
                            }.padding(.bottom, 30)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Units")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    TextField("", text: $inventoryVM.unitsInput)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                        .background(.white)
                                        .frame(width: 150, height: 40)
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.center)
                                        
                                }.padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Current Stock")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    TextField("", text: $inventoryVM.currentStockInput)
                                        .background(.white)
                                        .frame(width: 150, height: 40)
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.decimalPad)
                                        .onReceive(Just(inventoryVM.currentStockInput)) { newValue in
                                            let filtered = newValue.filter { ".0123456789".contains($0) }
                                            if filtered != newValue {
                                                inventoryVM.currentStockInput = filtered
                                            }
                                        }
                                }.padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Min. Threshold")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    TextField("", text: $inventoryVM.minimumThresholdInput)
                                        .background(.white)
                                        .frame(width: 150, height: 40)
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.decimalPad)
                                        .onReceive(Just(inventoryVM.minimumThresholdInput)) { newValue in
                                            let filtered = newValue.filter { ".0123456789".contains($0) }
                                            if filtered != newValue {
                                                inventoryVM.minimumThresholdInput = filtered
                                            }
                                        }
                                }.padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Cost Per Unit")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Text("$")
                                    TextField("", text: $inventoryVM.costPerUnitInput)
                                        .background(.white)
                                        .frame(width: 120, height: 40)
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.decimalPad)
                                        .onReceive(Just(inventoryVM.costPerUnitInput)) { newValue in
                                            let filtered = newValue.filter { ".0123456789".contains($0) }
                                            if filtered != newValue {
                                                inventoryVM.costPerUnitInput = filtered
                                            }
                                        }
                                }.padding(.horizontal, 20)
                                
                                // TODO: Warnings
                                
                                VStack {
                                    Text("Comment")
                                        .fontWeight(.bold)
                                    
                                    TextEditor(text: $inventoryVM.commentInput)
                                        .foregroundColor(.black)
                                        .font(.system(size: 25))
                                        .background(.white)
                                        .frame(height: 200)
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.leading)
                                        
                                }.padding(.horizontal, 20)
                                    .padding(.bottom, 10)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
                                
                                Text("Remove Ingredient")
                                    .fontWeight(.bold)
                                
                                Button(action: {
                                    inventoryVM.nameInput = selectedIngredient.id!
                                    confirmingDelete = true
                                }) {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 40))
                                }
                            }.padding(.horizontal, 20)

                            Button(action: {
                                inventoryVM.nameInput = selectedIngredient.id!
                                inventoryVM.editIngredient()
                                if inventoryVM.error == "" {
                                    self.selectedIngredient = nil
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(30)
                                        .foregroundColor(Color.blue)
                                        .frame(width: 380, height: 85)
                                        .padding(.bottom, 10)
                                    
                                    Text("Save changes")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 10)
                                        .font(.system(size: 35))
                                }
                            }
                            
                            Text("\(inventoryVM.error)")
                                .foregroundColor(.red)
                                .font(.system(size: 22))
                                .frame(maxWidth: 380)
                            
                        } else {
                            Text("Select an ingredient")
                                .font(Font.custom("DIN Bold", size: 60))
                        }
                        
                    }.frame(maxWidth: 450, maxHeight: 700)
                    .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                    .font(.system(size: 30))
                }
            }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .navigationBarHidden(true)
                .onAppear {
                    inventoryVM.getInventory()
                }
            
        } else {
            ZStack {
                Color(red: 220/255, green: 220/255, blue: 220/255).ignoresSafeArea()
                RoundedRectangle(cornerRadius:20)
                    .frame(width: 400, height: 220)
                    .foregroundColor(.white)
                
                VStack {
                    if confirmingDelete {
                        Text("**Delete Ingredient \(inventoryVM.nameInput)?**")
                            .font(.system(size: 40))
                        Spacer()
                        HStack {
                            Button(action: {
                                confirmingDelete = false
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 40))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                inventoryVM.removeIngredient()
                                self.selectedIngredient = nil
                                confirmingDelete = false
                            }) {
                                Text("Delete")
                                    .foregroundColor(.red)
                                    .font(.system(size: 40))
                            }
                        }.padding(.horizontal, 50)

                    } else if editingIngredientName {
                        Text("**Edit Ingredient Name**")
                            .font(.system(size: 30))
                        Text("\(self.selectedIngredient!.id!)")
                            .font(.system(size: 23))
                            .foregroundColor(.orange)
                        Spacer()
                        HStack {
                            Text("**New Name**")
                                .font(.system(size: 20))
                            Spacer()
                            TextField("", text: $inventoryVM.newNameInput)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .frame(width: 150, height: 40)
                                .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                                .cornerRadius(25)
                                .multilineTextAlignment(.center)
                        }.padding(.horizontal, 50)
                        Spacer()
                        HStack {
                            Button(action: {
                                inventoryVM.error = ""
                                editingIngredientName = false
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                inventoryVM.nameInput = selectedIngredient!.id!
                                inventoryVM.editIngredientName()
                                if inventoryVM.error == "" {
                                    self.selectedIngredient = nil
                                    inventoryVM.newNameInput = ""
                                    editingIngredientName = false
                                }
                            }) {
                                Text("Save Changes")
                                    .font(.system(size: 20))
                            }
                        }.padding(.horizontal, 50)
                  
                        
                        Text("\(inventoryVM.error)")
                            .foregroundColor(.red)
                            .font(.system(size: 22))
                            .frame(maxWidth: 380)
                    }
                }.frame(width: 400, height: 160)
            }
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
