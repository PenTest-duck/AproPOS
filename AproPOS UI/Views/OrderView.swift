//
//  OrderView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 14/7/22.
//

import SwiftUI
import Combine

struct OrderView: View {
    @StateObject private var orderVM = OrderViewModel()
    @StateObject private var menuVM = MenuViewModel()
        
    @State private var selectedMenuItem: MenuItemModel? = nil
    
    var body: some View {
        ZStack {
            HStack (spacing: 0) {
                VStack {
                    VStack {
                        // Centered order statistics
                        ZStack {
                            HStack {
                                // Total orders
                                VStack {
                                    Text("Total")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(orderVM.orderStatistics["total"]!)")
                                        .font(.system(size: 60))
                                        .fontWeight(.bold)
                                }.padding(.horizontal, 20)
                                
                                // Preparing orders
                                VStack {
                                    Text("Preparing")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(orderVM.orderStatistics["preparing"]!)")
                                        .font(.system(size: 60))
                                        .fontWeight(.bold)
                                }.padding(.horizontal, 20)
                                
                                // Overdue orders
                                VStack {
                                    Text("Overdue")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(orderVM.orderStatistics["overdue"]!)")
                                        .font(.system(size: 60))
                                        .fontWeight(.bold)
                                }.padding(.horizontal, 20)
                                
                                // Served orders
                                VStack {
                                    Text("Served")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(orderVM.orderStatistics["served"]!)")
                                        .font(.system(size: 60))
                                        .fontWeight(.bold)
                                }.padding(.horizontal, 20)
                            }.frame(width: 1070) // static value
                                .padding(.vertical, 10)
                                .background(Color(red: 237/255, green: 106/255, blue: 90/255))
                        }
                    }
                    
                    ScrollView {
                        if orderVM.orderStatistics["preparing"] == 0 && orderVM.orderStatistics["overdue"] == 0 { // View for for when there are no outstanding orders
                            Spacer()
                            VStack(spacing: 10) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 50))
                                Text("No orders")
                                    .font(.system(size: 50))
                                    .fontWeight(.semibold)
                                Text("Add an order by pressing the New Order icon")
                                    .font(.system(size: 20))
                            }.padding(.bottom, 90)
                            Spacer()
                            
                        } else { // If at least one outstanding order exists
                            // Grid of every order
                            LazyVGrid(columns: [.init(.adaptive(minimum: 200, maximum: .infinity), spacing: 15, alignment: .top)], spacing: 15) {
                                ForEach(orderVM.orders.sorted(by: { Int($0.id!)! < Int($1.id!)! } ).filter { $0.status != "served" } ) { order in // sorting by ascending order of table number
                                    // Pressing it will open NewOrderView() with prefilled values (= editing)
                                    NavigationLink (destination: NewOrderView().environmentObject(menuVM).environmentObject(orderVM)
                                            .onAppear {
                                                orderVM.editingOrder = true
                                                orderVM.tableNumberInput = order.id!
                                                orderVM.menuItemsInput = order.menuItems
                                            }
                                        )
                                    {
                                        IndividualOrderView(order: order)
                                            .environmentObject(orderVM)
                                    }
                                }
                            }.frame(width: 1000)
                            Spacer()
                        }
                    }
                }.ignoresSafeArea()
                
                // New order button
                NavigationLink (destination: NewOrderView().environmentObject(menuVM).environmentObject(orderVM)
                                    .onAppear {
                    // Clear variables
                    orderVM.error = ""
                    orderVM.editingOrder = false
                    orderVM.tableNumberInput = ""
                    orderVM.menuItemsInput = [OrderedMenuItem]()
                }) {
                    VStack {
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 100))
                            .foregroundColor(Color(red: 32/255, green: 30/255, blue: 80/255))
                        Text("New Order")
                            .font(Font.custom("DIN Bold", size: 80))
                            .foregroundColor(Color.white)
                    }
                }.frame(maxWidth: 300, maxHeight: .infinity)
                    .background(Color(red: 237/255, green: 106/255, blue: 90/255))
                
            }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .onAppear {
                    // Start synchronising data
                    orderVM.getOrders()
                }
            
            // Help button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Link(destination: URL(string: "https://docs.google.com/document/d/1fmndVOoGDhNku8Z8J-9fgqND61m4VME4OHuz0bK8KRA/edit#bookmark=kix.gru3sr89fcqi")!) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 70))
                    }
                }.padding(.trailing, 40)
            }.padding(.bottom, 20)
        }.onAppear {
            orderVM.monitorOverdue() // Run first as viewDidLoad() will start running 5 seconds afterwards
            orderVM.viewDidLoad()
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().previewInterfaceOrientation(.landscapeLeft)
    }
}
