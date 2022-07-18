//
//  ImplementBillingView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import SwiftUI

struct ImplementBillingView: View {
    
    @StateObject private var orderVM = OrderViewModel()
    @StateObject private var billingVM = BillingViewModel()
    
    var body: some View {
        VStack {
            TextField(" Table Number", text: $billingVM.tableNumberInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            // TODO: Fix showing value at the start
            TextField(" Discount", value: $billingVM.discountInput, formatter: NumberFormatter())
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            Button(action: {
                //billingVM.serverInput = "Chris Yoo"
                billingVM.processBill()
            }) {
                Text("Process bill")
            }
            
            Button(action: {
                billingVM.getBillsHistory()
            }) {
                Text("Get bills")
            }
            
            Button(action: {
                orderVM.getOrders()
            }) {
                Text("Get orders")
            }
        }
        .onAppear {
            orderVM.getOrders()
            billingVM.getBillsHistory()
        }
    }
}

struct ImplementBillingView_Previews: PreviewProvider {
    static var previews: some View {
        ImplementBillingView().previewInterfaceOrientation(.landscapeLeft)
    }
}
