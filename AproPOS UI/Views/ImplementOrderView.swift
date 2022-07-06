//
//  ImplementOrderView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 12/5/22.
//

import SwiftUI

struct ImplementOrderView: View {
    @StateObject private var orderVM = OrderViewModel()
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        VStack {
            Text("Message: \(orderVM.message)")
            
            TextField(" Table Number", text: $orderVM.tableNumberInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            
            
            Button(action: {
                orderVM.menuItemsInput = ["Noodles" : 2, "Fried Rice" : 3]
                orderVM.addOrder()
                
            }) {
                Text("Add Order")
            }
            
            Button(action: {
                orderVM.getOrders()
            }) {
                Text("Get Orders")
            }
            
            Button(action: {
                orderVM.removeOrder()
            }) {
                Text("Remove Order")
            }
            
            Button(action: {
                orderVM.editOrder()
            }) {
                Text("Edit Order")
            }
            
            Button(action: {
                authVM.logout()
            }) {
                Text("Logout")
            }
        }
        .onAppear {
            orderVM.getOrders()
        }
    }
}

struct ImplementOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ImplementOrderView().previewInterfaceOrientation(.landscapeLeft)
    }
}
