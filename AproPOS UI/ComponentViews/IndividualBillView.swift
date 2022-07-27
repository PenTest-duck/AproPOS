//
//  IndividualBillView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 18/7/22.
//

import SwiftUI
import Combine

struct IndividualBillView: View {
    @EnvironmentObject var billingVM: BillingViewModel
    
    let order: OrderModel
    
    @State private var inputDiscount = false
    @State private var discountInput: String = "0.00"
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy h:mm a"
        return formatter
    }()
    
    // TODO: Currency Formatter
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 2)
                .foregroundColor(.white)
            
            VStack {
                Text("Table \(order.id!)")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                ForEach(order.menuItems, id: \.name) { menuItem in
                    HStack {
                        Text("\(menuItem.quantity)    ")
                            .font(.system(size: 30))
                        
                        Text("\(menuItem.name)")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("$\(String(describing: menuItem.price))")
                            .font(.system(size: 30))
                    }
                }
                
                Spacer()
                
                HStack {
                    if !billingVM.viewingPastBill {
                        ZStack {
                            Button(action: {
                                inputDiscount = true
                            }) {
                                if !inputDiscount {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color(red: 160/255, green: 236/255, blue: 208/255))
                                            .frame(width: 200, height: 50)
                                        
                                        Text("Discount")
                                            .foregroundColor(.black)
                                            .fontWeight(.semibold)
                                            .font(.system(size: 30))
                                        
                                    }
                                }
                            }
                            
                            if inputDiscount {
                                VStack {
                                    HStack {
                                        Text("$")
                                            .foregroundColor(.black)
                                            .font(.system(size: 35))
                                        
                                        TextField("", text: $discountInput)
                                            .background(Color(red: 232/255, green: 211/255, blue: 185/255))
                                            .cornerRadius(25)
                                            .frame(width: 180, height: 40)
                                            .foregroundColor(.black)
                                            .font(.system(size: 30))
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.decimalPad)
                                            .onReceive(Just(discountInput)) { newValue in
                                                let filtered = newValue.filter { ".0123456789".contains($0) }
                                                if filtered != newValue {
                                                    discountInput = filtered
                                                }
                                            }
                                        
                                        Button(action: {
                                            billingVM.validateDiscount(discount: discountInput, subtotal: order.subtotalPrice)
                                            if billingVM.error == "" {
                                                billingVM.discountInput = discountInput
                                                inputDiscount = false
                                            }
                                        }) {
                                            Image(systemName: "checkmark.square")
                                                .font(.system(size: 35))
                                        }
                                    }
                                    
                                    Text("\(billingVM.error)")
                                        .foregroundColor(.red)
                                        .font(.system(size: 18))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: 200)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        if billingVM.viewingPastBill {
                            Text("Server: \(billingVM.server)")
                                .padding(.bottom, 30)
                        }
                        
                        Text("Sub Total: **$\(String(describing: order.subtotalPrice))**")
                        Text("Discount: **$\(billingVM.discountInput)**")
                        Text("Total: **$\(String(describing: (order.subtotalPrice - Decimal(Double(billingVM.discountInput)!))))**")
                    }.font(.system(size: 25))
                }.padding(.bottom, 50)
                
                if !billingVM.viewingPastBill {
                    Button(action: {
                        billingVM.tableNumberInput = order.id!
                        billingVM.processBill()
                        billingVM.selectedOrder = nil
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(20)
                                .foregroundColor(Color(red: 8/255, green: 61/255, blue: 119/255))
                                .frame(width: 250, height: 50)
                                .padding(.bottom, 10)
                            
                            Text("Process bill")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.bottom, 10)
                                .font(.system(size: 35))
                        }
                    }
                }
                
            }.padding(.top, 30)
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
        }
    }
}

struct IndividualBillView_Previews: PreviewProvider {
    static var previews: some View {
        //let sampleOrder = OrderModel(id: "7", orderTime: Date(), status: "preparing", menuItems: [OrderedMenuItem(name: "Fried Rice", quantity: 2, price: 14.8, served: false), OrderedMenuItem(name: "Noodles", quantity: 5, price: 22.5, served: true), OrderedMenuItem(name: "Pasta", quantity: 3, price: 13.5, served: false)], subtotalPrice: 50.8)
        
        /*IndividualBillView(order: sampleOrder)
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(BillingViewModel())
            .frame(width: 850, height: 850)*/
        BillingView().previewInterfaceOrientation(.landscapeLeft)
    }
}
