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
    @StateObject private var orderVM = OrderViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedMenuItem: MenuItemModel? = nil
    // @State private var selectedOrder: OrderModel? = nil

    var body: some View {
        HStack (spacing: 0) {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Text("New Order")
                                .font(.system(size: 55))
                                .fontWeight(.bold)
                        }
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
                        Text("Go to the Menu page to add your first menu item")
                            .font(.system(size: 20))
                    }.padding(.bottom, 90)
                    Spacer()
                } else {
                    LazyVGrid(columns: [.init(.adaptive(minimum: 200, maximum: .infinity), spacing: 5)], spacing: 5) {
                        ForEach(menuVM.menu) { menuItem in
                            Button(action: {
                                if orderVM.menuItemsInput.first(where: { $0.name == menuItem.id! } ) == nil {
                                    orderVM.menuItemsInput.append(OrderedMenuItem(name: menuItem.id!, quantity: 1, price: 100))
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
                .background(.red)
            
            VStack {
                Text("New Order")
                    .font(Font.custom("DIN Bold", size: 60))
            
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
                        .onReceive(Just(orderVM.tableNumberInput)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                orderVM.tableNumberInput = filtered
                            }
                        }
                        
                }.padding(.horizontal, 20)

                MenuDropDownInputView().environmentObject(orderVM)
                    .padding(.horizontal, 20)
                    .frame(height: 500)
                
                Spacer()
                
                Button(action: {
                    orderVM.addOrder() { (_ success) -> Void in
                        if orderVM.error == "" {
                            presentationMode.wrappedValue.dismiss() // creates top blank bar
                        }
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(30)
                            .foregroundColor(Color.blue)
                            .frame(width: 380, height: 100)
                            .padding(.bottom, 10)
                        
                        Text("Add Order")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                            .font(.system(size: 35))
                    }
                }
                
                Text("\(orderVM.error)")
                    .foregroundColor(.red)
                    .font(.system(size: 22))
                    .frame(maxWidth: 380)
            }.frame(maxWidth: 450, maxHeight: .infinity)
            .background(Color(red: 242/255, green: 242/255, blue: 248/255))
            .font(.system(size: 30))
        }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
            .navigationBarHidden(true)
            .onAppear {
                menuVM.getMenu()
                menuVM.checkUnavailableMenuItems()
                // may be unnecessary?
                orderVM.getOrders()
            }
    }
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView().previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(MenuViewModel())
    }
}
