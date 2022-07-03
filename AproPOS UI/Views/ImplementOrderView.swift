//
//  ImplementOrderView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 12/5/22.
//

import SwiftUI

struct ImplementOrderView: View {
    @StateObject private var orderVM = OrderViewModel()
    
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
                testOrderMenuItems()
                
                orderVM.addOrder()
                
            }) {
                Text("Add Order")
            }
            
            Button(action: {
                orderVM.getOrders()
            }) {
                Text("Get Orders")
            }
        }
        .onAppear {
            orderVM.getOrders()
        }
    }
    
    func testOrderMenuItems() { // for testing only
        orderVM.orderedMenuItemsInput = ["Noodles" : 2, "Fried Rice" : 3]
    }
}

struct ImplementOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ImplementOrderView().previewInterfaceOrientation(.landscapeLeft)
    }
}
