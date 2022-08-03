//
//  NewOrderView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 12/7/22.
//

import SwiftUI
import Combine

struct NewOrderView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    @EnvironmentObject var orderVM: OrderViewModel
    
    // Allowing dismissal of views to go back one view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedMenuItem: MenuItemModel? = nil

    var body: some View {
        ZStack {
            HStack (spacing: 0) {
                VStack {
                    // Centered title
                    VStack {
                        ZStack {
                            HStack {
                                Text(orderVM.editingOrder ? "Order for Table \(orderVM.tableNumberInput)" : "New Order")
                                    .font(.system(size: 60))
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    
                    if menuVM.menu == [] { // View for when there are no menu items
                        Spacer()
                        VStack(spacing: 10) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: 50))
                            Text("No menu items")
                                .font(.system(size: 50))
                                .fontWeight(.semibold)
                            Text("Go to the Menu page to add your first menu item")
                                .font(.system(size: 20))
                        }.padding(.bottom, 90)
                        Spacer()
                    } else { // If at least one menu item exists
                        // Grid of every menu item
                        LazyVGrid(columns: [.init(.adaptive(minimum: 200, maximum: .infinity), spacing: 5)], spacing: 5) {
                            ForEach(menuVM.menu) { menuItem in
                                Button(action: {
                                    // If menu item has not been added to the order already
                                    if orderVM.menuItemsInput.first(where: { $0.name == menuItem.id! } ) == nil {
                                        // Initially get the price of 1 of that menu item
                                        orderVM.initPrice(name: menuItem.id!) { (price) -> Void in
                                            // Append to menuItemsInput
                                            orderVM.menuItemsInput.append(OrderedMenuItem(name: menuItem.id!, quantity: 1, price: price, served: false))
                                        }
                                    }
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
                
                // Input fields
                VStack {
                    Text("Order")
                        .font(Font.custom("DIN Bold", size: 60))
                
                    // Table input
                    HStack {
                        Text("Table")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        TextField("", text: $orderVM.tableNumberInput)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(.white)
                            .frame(width: 300, height: 40)
                            .cornerRadius(25)
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .onReceive(Just(orderVM.tableNumberInput)) { newValue in // Filter only numbers
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    orderVM.tableNumberInput = filtered
                                }
                            }
                            
                    }.padding(.horizontal, 20)

                    // Menu items input
                    MenuDropDownInputView().environmentObject(orderVM)
                        .padding(.horizontal, 20)
                        .frame(height: 500)
                    
                    // Calculate and update total price in real time
                    Text("Total Price: $\(String(describing: orderVM.totalPrice()))")
                    
                    Spacer()
                    
                    // Add order button
                    Button(action: {
                        orderVM.addOrder() { (_ success) -> Void in
                            if orderVM.error == "" {
                                orderVM.editingOrder = false
                                presentationMode.wrappedValue.dismiss() // returns to OrderView
                            }
                        }
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(30)
                                .foregroundColor(Color(red: 8/255, green: 61/255, blue: 119/255))
                                .frame(width: 380, height: 100)
                                .padding(.bottom, 10)
                            
                            Text(orderVM.editingOrder ? "Edit Order" : "Add Order") // Varying text for edit status
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.bottom, 10)
                                .font(.system(size: 35))
                        }
                    }
                    
                    // Error display
                    Text("\(orderVM.error)")
                        .foregroundColor(.red)
                        .font(.system(size: 22))
                        .frame(maxWidth: 380)
                    
                }.frame(maxWidth: 450, maxHeight: .infinity)
                .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .font(.system(size: 30))
                
            }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .onAppear {
                    // Start synchronising data
                    menuVM.getMenu()
                    menuVM.checkUnavailableMenuItems()
                    orderVM.getOrders()
                }
            
            // Help button
            VStack {
                HStack {
                    Spacer()
                    Link(destination: URL(string: "https://docs.google.com/document/d/1fmndVOoGDhNku8Z8J-9fgqND61m4VME4OHuz0bK8KRA/edit#bookmark=id.iw3dn7mc99d9")!) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 50))
                    }
                }.padding(.trailing, 40)
                Spacer()
            }.padding(.top, 12)
        }
    }
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView().previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(MenuViewModel())
            .environmentObject(OrderViewModel())
    }
}
