//
//  ImplementMenuView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import SwiftUI

struct ImplementMenuView: View {
    
    @StateObject private var menuVM = MenuViewModel()
    
    var body: some View {
        VStack {
            Text("Message: \(menuVM.error)")
            
            TextField(" Name", text: $menuVM.nameInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            ImagePicker(sourceType: .photoLibrary, selectedImage: $menuVM.imageInput)
            
            Button(action: {
                menuVM.priceInput = "4.50"
                menuVM.ESTInput = "25"
                menuVM.ingredientsInput = ["eggs" : 5, "bread" : 2]
                menuVM.addMenuItem()
            }) {
                Text("Add Menu Item")
            }
            
            Button(action: {
                menuVM.getMenu()
            }) {
                Text("Get Menu")
            }
            
            Button(action: {
                menuVM.editMenuItem()
            }) {
                Text("Edit menu item")
            }
            
            Button(action: {
                menuVM.checkUnavailableMenuItems()
            }) {
                Text("Check Unavailable")
            }
            
            Button(action: {
                menuVM.removeMenuItem()
            }) {
                Text("Remove menu item")
            }
        }
        .onAppear {
            menuVM.getMenu()
        }
    }
}

struct ImplementMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ImplementMenuView().previewInterfaceOrientation(.landscapeLeft)
    }
}
