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
            Text("Message: \(menuVM.message)")
            
            TextField(" Name", text: $menuVM.menuItemNameInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            Button(action: {
                testMenuItem()
                menuVM.addMenuItem()
                menuVM.getMenu()
                
            }) {
                Text("Add Menu Item")
            }
            
            Button(action: {
                menuVM.getMenu()
            }) {
                Text("Get Menu")
            }
        }
        .onAppear {
            menuVM.getMenu()
        }
    }
    
    func testMenuItem() {
        menuVM.menuItemPriceInput = 4.50
        menuVM.menuItemEstimatedServingTimeInput = 25
        menuVM.menuItemIngredientsInput = ["eggs" : 5, "bread" : 2]
        
    }
}

struct ImplementMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ImplementMenuView().previewInterfaceOrientation(.landscapeLeft)
    }
}
