//
//  MenuDropDownInputView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 13/7/22.
//

import SwiftUI
import Combine

struct MenuDropDownInputView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @StateObject private var menuVM = MenuViewModel()
    
    @State private var selectedMenuItem: OrderedMenuItem? = nil
    //@State private var quantity: Int = 1
    @State private var quantities: [String: Int] = [:]
    
    static var uniqueKey: String {
        UUID().uuidString
    }
    
    @State private var options: [DropdownOption] = []
    
    func incrementStep(name: String) {
        if quantities[name]! <= 98 {
            quantities[name]! += 1
            if let index = orderVM.menuItemsInput.firstIndex(where: { $0.name == name } ) {
                let quantity = orderVM.menuItemsInput[index].quantity + 1
                let price = (orderVM.menuItemsInput[index].price / Decimal(orderVM.menuItemsInput[index].quantity)) * Decimal(orderVM.menuItemsInput[index].quantity + 1)
                let served = orderVM.menuItemsInput[index].served

                orderVM.menuItemsInput[index] = OrderedMenuItem(name: name, quantity: quantity, price: price, served: served)
            }
        }
    }
    
    func decrementStep(name: String) {
        if quantities[name]! >= 2 {
            quantities[name]! -= 1
            if let index = orderVM.menuItemsInput.firstIndex(where: { $0.name == name } ) {
                let quantity = orderVM.menuItemsInput[index].quantity - 1
                let price = (orderVM.menuItemsInput[index].price / Decimal(orderVM.menuItemsInput[index].quantity)) * Decimal(orderVM.menuItemsInput[index].quantity - 1)
                let served = orderVM.menuItemsInput[index].served

                orderVM.menuItemsInput[index] = OrderedMenuItem(name: name, quantity: quantity, price: price, served: served)
            }
        }
    }
            
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 249/255, green: 228/255, blue: 183/255))
                
                if orderVM.menuItemsInput.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                            .font(.system(size: 50))
                        Text("No menu items")
                            .font(.system(size: 40))
                            .fontWeight(.semibold)
                        Text("Press menu items to add them to the order.")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                    }
                } else {
                    VStack(spacing: 0) {
                        ForEach(orderVM.menuItemsInput, id: \.name) { menuItem in
                            ZStack {
                                ZStack {
                                    Rectangle()
                                        .stroke(.blue, lineWidth: 2)
                                        .background(Rectangle().fill(.yellow))
                                        .frame(height: 40)
                                    
                                    HStack {
                                        
                                        Button(action: {
                                            decrementStep(name: menuItem.name)
                                        }) {
                                            Text("-")
                                                .font(.system(size: 25))
                                                .fontWeight(.bold)
                                        }

                                        
                                        Text("\(quantities[menuItem.name] ?? 1)")
                                            .font(.system(size: 20))
                                        
                                        Button(action: {
                                            incrementStep(name: menuItem.name)
                                        }) {
                                            Text("+")
                                                .font(.system(size: 25))
                                                .fontWeight(.bold)
                                        }
                                        
                                        if let index = orderVM.menuItemsInput.firstIndex(where: { $0.name == menuItem.name } ) {
                                            Text("$\(String(describing: orderVM.menuItemsInput[index].price))")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 20))
                                        }
                                        
                                        Spacer()
                                        
                                        Text("\(String(describing: menuItem.name))")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                    }.padding(.horizontal, 20)
                                }
                                
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        if let index = orderVM.menuItemsInput.firstIndex(of: menuItem) {
                                            orderVM.menuItemsInput.remove(at: index)
                                        }
                                    }) {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                            .font(.system(size: 28))
                                    }
                                }.padding(.horizontal, 5)
                            }.onAppear {
                                if quantities.firstIndex(where: { $0.key == menuItem.name } ) == nil {
                                    quantities[menuItem.name] = 1
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct MenuDropDownInputView_Previews: PreviewProvider {
    //static let orderVM = OrderViewModel()
    
    static var previews: some View {

        //orderVM.menuItemsInput.append(OrderedMenuItem(name: "Pasta", quantity: 2, price: 20))
        
        /*MenuDropDownInputView()
            .frame(width: 350, height: 500)
            .environmentObject(OrderViewModel()) //orderVM*/
        NewOrderView().previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(MenuViewModel())
            .environmentObject(OrderViewModel())
    }
}
