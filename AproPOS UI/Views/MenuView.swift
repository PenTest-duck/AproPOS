//
//  MenuView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 8/7/22.
//

import SwiftUI
import Combine

struct MenuView: View {
    
    @StateObject var menuVM = MenuViewModel()
    
    @State private var selectedMenuItem: MenuItemModel? = nil
    @State private var addingMenuItem: Bool = false
    @State private var confirmingDelete: Bool = false
    @State private var editingMenuItemName: Bool = false

    var body: some View {
        ZStack {
            if !confirmingDelete && !editingMenuItemName {
                HStack (spacing: 0) {
                    VStack {
                        VStack {
                            ZStack {
                                HStack {
                                    Text("Menu Items")
                                        .font(.system(size: 60))
                                        .fontWeight(.bold)
                                }
                                    
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        addingMenuItem = true
                                        menuVM.error = ""
                                        menuVM.nameInput = ""
                                        menuVM.priceInput = "0.00"
                                        menuVM.ESTInput = "0"
                                        menuVM.warningsInput = []
                                        menuVM.ingredientsInput = [:]
                                        menuVM.imageInput = UIImage(named: "defaultMenuItemImage")!
                                        
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
                        
                        if menuVM.menu == [] {
                            Spacer()
                            VStack(spacing: 10) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 50))
                                Text("No menu items")
                                    .font(.system(size: 50))
                                    .fontWeight(.semibold)
                                Text("Create your first menu item by pressing the add icon.")
                                    .font(.system(size: 20))
                            }.padding(.bottom, 90)
                            Spacer()
                        } else {
                            LazyVGrid(columns: [.init(.adaptive(minimum: 200, maximum: .infinity), spacing: 5)], spacing: 5) {
                                ForEach(menuVM.menu) { menuItem in
                                    Button(action: {
                                        addingMenuItem = false
                                        menuVM.error = ""
                                        selectedMenuItem = menuItem
                                        menuVM.priceInput = String(describing: selectedMenuItem!.price)
                                        menuVM.ESTInput = String(describing: selectedMenuItem!.estimatedServingTime)
                                        menuVM.warningsInput = selectedMenuItem!.warnings
                                        menuVM.ingredientsInput = selectedMenuItem!.ingredients
                                        menuVM.imageInput = UIImage(data: selectedMenuItem!.image)!
                                    }) {
                                        IndividualMenuItemView(menuItem: menuItem).environmentObject(menuVM)
                                    }
                                }
                            }.padding(.leading, 10)
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    Divider()
                        .frame(width: 10)
                        .background(Color(red: 202/255, green: 85/255, blue: 220/255))
                    
                    ScrollView {
                        VStack {
                            if addingMenuItem {
                                Group {
                                    Text("New")
                                        .font(Font.custom("DIN Bold", size: 60))
                                    
                                    Text("Menu Item")
                                        .font(Font.custom("DIN Bold", size: 60))
                                }
                                
                                HStack {
                                    Text("Name")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    TextField("", text: $menuVM.nameInput)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                        .background(.white)
                                        .frame(width: 300, height: 40)
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.center)
                                        
                                }.padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Price")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Text("$")
                                    TextField("", text: $menuVM.priceInput)
                                        .background(.white)
                                        .frame(width: 120, height: 40)
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.decimalPad)
                                        .onReceive(Just(menuVM.priceInput)) { newValue in
                                            let filtered = newValue.filter { ".0123456789".contains($0) }
                                            if filtered != newValue {
                                                menuVM.priceInput = filtered
                                            }
                                        }
                                }.padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Estimated Serving Time")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    TextField("", text: $menuVM.ESTInput)
                                        .background(.white)
                                        .frame(width: 100, height: 40)
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.numberPad)
                                        .onReceive(Just(menuVM.ESTInput)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                menuVM.ESTInput = filtered
                                            }
                                        }
                                    
                                    Text("mins")
                                }.padding(.horizontal, 20)
                                
                                
                                // TODO: Warnings
                                
                                // TODO: Ingredients
                                IngredientDropDownInputView().environmentObject(menuVM)
                                    .padding(.horizontal, 20)
                                    .frame(height: 500)
                                
                                VStack {
                                    Text("Image")
                                        .fontWeight(.bold)
                                    
                                    ImagePicker(sourceType: .photoLibrary, selectedImage: $menuVM.imageInput)
                                }.padding(.horizontal, 20)
                                
                                Spacer()
                                
                                Button(action: {
                                    menuVM.addMenuItem()
                                    if menuVM.error == "" {
                                        self.selectedMenuItem = nil
                                        addingMenuItem = false
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .cornerRadius(30)
                                            .foregroundColor(Color(red: 8/255, green: 61/255, blue: 119/255))
                                            .frame(width: 380, height: 100)
                                            .padding(.bottom, 10)
                                        
                                        Text("Add Menu Item")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .padding(.bottom, 10)
                                            .font(.system(size: 35))
                                    }
                                }
                                
                                Text("\(menuVM.error)")
                                    .foregroundColor(.red)
                                    .font(.system(size: 22))
                                    .frame(maxWidth: 380)
                                
                            } else if let selectedMenuItem = selectedMenuItem {
                                Text("\(selectedMenuItem.id!)")
                                    .font(Font.custom("DIN Bold", size: 60))
                                
                                Button(action: {
                                    editingMenuItemName = true
                                }) {
                                    HStack {
                                        Image(systemName: "pencil.tip.crop.circle")
                                        Text("Edit Menu Item Name")
                                    }.font(.system(size: 20))
                                }.padding(.bottom, 30)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Price")
                                            .fontWeight(.bold)
                                        
                                        Spacer()
                                        
                                        Text("$")
                                        TextField("", text: $menuVM.priceInput)
                                            .background(.white)
                                            .frame(width: 120, height: 40)
                                            .cornerRadius(25)
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.decimalPad)
                                            .onReceive(Just(menuVM.priceInput)) { newValue in
                                                let filtered = newValue.filter { ".0123456789".contains($0) }
                                                if filtered != newValue {
                                                    menuVM.priceInput = filtered
                                                }
                                            }
                                    }.padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("Estimated Serving Time")
                                            .fontWeight(.bold)
                                        
                                        Spacer()
                                        
                                        TextField("", text: $menuVM.ESTInput)
                                            .background(.white)
                                            .frame(width: 100, height: 40)
                                            .cornerRadius(25)
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.numberPad)
                                            .onReceive(Just(menuVM.ESTInput)) { newValue in
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    menuVM.ESTInput = filtered
                                                }
                                            }
                                        
                                        Text("mins")
                                    }.padding(.horizontal, 20)
                                    
                                    
                                    // TODO: Warnings
                                    
                                    // TODO: Ingredients
                                    IngredientDropDownInputView().environmentObject(menuVM)
                                        .padding(.horizontal, 20)
                                        .frame(height: 500)
                                    
                                    VStack {
                                        Text("Image")
                                            .fontWeight(.bold)
                                        
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: $menuVM.imageInput)
                                    }.padding(.horizontal, 20)
                                }
                                
                                Spacer()
                                
                                

                                Button(action: {
                                    menuVM.nameInput = selectedMenuItem.id!
                                    menuVM.editMenuItem()
                                    if menuVM.error == "" {
                                        self.selectedMenuItem = nil
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .cornerRadius(30)
                                            .foregroundColor(Color(red: 8/255, green: 61/255, blue: 119/255))
                                            .frame(width: 380, height: 85)
                                            .padding(.bottom, 10)
                                        
                                        Text("Save changes")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .padding(.bottom, 10)
                                            .font(.system(size: 35))
                                    }
                                }
                                
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        menuVM.nameInput = selectedMenuItem.id!
                                        confirmingDelete = true
                                    }) {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 40))
                                            .padding(.trailing, 170)
                                    }
                                }.padding(.horizontal, 20)
                                
                                Text("\(menuVM.error)")
                                    .foregroundColor(.red)
                                    .font(.system(size: 22))
                                    .frame(maxWidth: 380)
                                
                            } else {
                                Text("Select a Menu Item")
                                    .font(Font.custom("DIN Bold", size: 60))
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 340)
                            }
                            
                        }.frame(maxWidth: 450, maxHeight: .infinity)
                        .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                        .font(.system(size: 30))
                    }
                }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
                    .navigationBarHidden(true)
                    .onAppear {
                        menuVM.getMenu()
                        menuVM.checkUnavailableMenuItems()
                    }
                
            } else {
                ZStack {
                    Color(red: 220/255, green: 220/255, blue: 220/255).ignoresSafeArea()
                    RoundedRectangle(cornerRadius:20)
                        .frame(width: 400, height: 220)
                        .foregroundColor(.white)
                    
                    VStack {
                        if confirmingDelete {
                            Text("**Delete Menu Item \(menuVM.nameInput)?**")
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
                                    menuVM.removeMenuItem()
                                    self.selectedMenuItem = nil
                                    confirmingDelete = false
                                }) {
                                    Text("Delete")
                                        .foregroundColor(.red)
                                        .font(.system(size: 40))
                                }
                            }.padding(.horizontal, 50)

                        } else if editingMenuItemName {
                            Text("**Edit Menu Item Name**")
                                .font(.system(size: 30))
                            Text("\(self.selectedMenuItem!.id!)")
                                .font(.system(size: 23))
                                .foregroundColor(.orange)
                            Spacer()
                            HStack {
                                Text("**New Name**")
                                    .font(.system(size: 20))
                                Spacer()
                                TextField("", text: $menuVM.newNameInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .frame(width: 150, height: 40)
                                    .background(Color(red: 237/255, green: 106/255, blue: 90/255))
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                            }.padding(.horizontal, 50)
                            Spacer()
                            HStack {
                                Button(action: {
                                    menuVM.error = ""
                                    editingMenuItemName = false
                                }) {
                                    Text("Cancel")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 20))
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    menuVM.nameInput = selectedMenuItem!.id!
                                    menuVM.editMenuItemName()
                                    if menuVM.error == "" {
                                        self.selectedMenuItem = nil
                                        menuVM.newNameInput = ""
                                        editingMenuItemName = false
                                    }
                                }) {
                                    Text("Save Changes")
                                        .font(.system(size: 20))
                                }
                            }.padding(.horizontal, 50)
                      
                            
                            Text("\(menuVM.error)")
                                .foregroundColor(.red)
                                .font(.system(size: 22))
                                .frame(maxWidth: 380)
                        }
                    }.frame(width: 400, height: 160)
                }
            }
            
            if !editingMenuItemName {
                VStack {
                    HStack {
                        Spacer()
                        
                        Link(destination: URL(string: "https://docs.google.com/document/d/1fmndVOoGDhNku8Z8J-9fgqND61m4VME4OHuz0bK8KRA/edit#bookmark=id.iw3dn7mc99d9")!) {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.system(size: 45))
                        }
                    }.padding(.trailing, 30)
                    
                    Spacer()
                }.padding(.top, 15)
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().previewInterfaceOrientation(.landscapeLeft)
    }
}
