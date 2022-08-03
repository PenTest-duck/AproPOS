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

    var timer = Timer()
/*
    func viewDidLoad() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            orderVM.monitorOverdue()
        })
    }*/

    var body: some View {
        ZStack {
            HStack (spacing: 0) {
                VStack {
                    VStack {
                        ZStack {
                            HStack {
                                VStack {
                                    Text("Total") // Show total amount of orders
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(orderVM.orderStatistics["total"]!)")
                                        .font(.system(size: 60))
                                        .fontWeight(.bold)
                                }.padding(.horizontal, 20)
                                
                                VStack {
                                    Text("Preparing") // Show How many orders are being prepared
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(orderVM.orderStatistics["preparing"]!)")
                                        .font(.system(size: 60))
                                        .fontWeight(.bold)
                                }.padding(.horizontal, 20)
                                
                                VStack {
                                    Text("Overdue") // Show how many orders are overdue
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(orderVM.orderStatistics["overdue"]!)")
                                        .font(.system(size: 60))
                                        .fontWeight(.bold)
                                }.padding(.horizontal, 20)
                                
                                VStack {
                                    Text("Served") // Show how many orders have been served
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
                    
                    ScrollView { // If there are no orders show the No Orders view
                        if orderVM.orderStatistics["preparing"] == 0 && orderVM.orderStatistics["overdue"] == 0 {
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
                        } else {
                            LazyVGrid(columns: [.init(.adaptive(minimum: 200, maximum: .infinity), spacing: 15, alignment: .top)], spacing: 15) {
                                ForEach(orderVM.orders.sorted(by: { Int($0.id!)! < Int($1.id!)! } ).filter { $0.status != "served" } ) { order in
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
                
                //Spacer()
                
                NavigationLink (destination: NewOrderView().environmentObject(menuVM).environmentObject(orderVM)
                                    .onAppear {
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
                            //.navigationBarTitle("")
                            //.navigationBarHidden(true)
                    }
                }//.navigationBarHidden(true)
                    .frame(maxWidth: 300, maxHeight: .infinity)
                    .background(Color(red: 237/255, green: 106/255, blue: 90/255))
                
            }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
                //.navigationBarHidden(true)
                .onAppear {
                    orderVM.getOrders()
                }
            
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
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().previewInterfaceOrientation(.landscapeLeft)
    }
}
