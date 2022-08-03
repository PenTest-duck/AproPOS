//
//  IndividualOrderView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 14/7/22.
//

import SwiftUI

struct IndividualOrderView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    
    @State private var EST: Int = 0
    
    let order: OrderModel
    
    var body: some View {
        ZStack {
            
            if order.status == "preparing" {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.green, lineWidth: 2)
                    .foregroundColor(.white)
            } else { // "overdue" case, and also potentially deals with erroneous "served" cases
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.orange, lineWidth: 2)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                Text("Table \(order.id!)")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 237/255, green: 106/255, blue: 90/255))
                    .font(.system(size: 50))
                
                ForEach(order.menuItems, id: \.name) { menuItem in
                    HStack {
                        
                        Button(action: {
                            orderVM.toggleMenuItemServed(tableNumber: order.id!, menuItems: order.menuItems, name: menuItem.name)
                            //menuItem.served.toggle()
                        }) {
                            if menuItem.served {
                                Text("**\(menuItem.quantity)**  \(menuItem.name)")
                                    .strikethrough(color: .red)
                            } else {
                                Text("**\(menuItem.quantity)**  \(menuItem.name)")
                            }
                        }
                    }.foregroundColor(.black)
                        .font(.system(size: 20))
                }
                
                Text("Estimated: \(EST) min")
                    .foregroundColor(.black)
                    .onAppear {
                        orderVM.calculateEST(menuItems: order.menuItems) { total in
                            EST = total
                        }
                    }
                
                HStack {
                    Button(action: {
                        orderVM.tableNumberInput = order.id!
                        orderVM.removeOrder()
                        orderVM.tableNumberInput = ""
                    }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 20))
                    }
                    
                    Button(action: {
                        orderVM.changeOrderStatus(tableNumber: order.id!, status: "served")
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 20))
                    }
                }.padding(.leading, 110)
                
                Spacer()
            }.padding(.top, 20)
                .padding(.horizontal, 10)
        }
    }
}

struct IndividualOrderView_Previews: PreviewProvider {
    static var sampleOrder = OrderModel(id: "7", orderTime: Date(), status: "overdue", menuItems: [OrderedMenuItem(name: "Fried Rice", quantity: 2, price: 14.8, served: false), OrderedMenuItem(name: "Noodles", quantity: 5, price: 22.5, served: true), OrderedMenuItem(name: "Pasta", quantity: 3, price: 13.5, served: false)], subtotalPrice: 50.8, estimatedServingTime: 15)
    
    static var previews: some View {
        //IndividualOrderView(order: sampleOrder)
            //.environmentObject(OrderViewModel())
        OrderView().previewInterfaceOrientation(.landscapeLeft)
    }
}
