//
//  BillingView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 18/7/22.
//

import SwiftUI
import Combine

struct BillingView: View {
    @StateObject private var billingVM = BillingViewModel()
    //@StateObject private var orderVM = OrderViewModel()
    
    @State private var selectedOrder: OrderModel? = nil
    @State private var confirmingDelete: Bool = false
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy h:mm a"
        return formatter
    }()
        
    var body: some View {
        HStack (spacing: 0) {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Text("Bills")
                                .font(.system(size: 55))
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    ZStack {
                        if selectedOrder == nil {
                            Text("Select a bill to view")
                                .font(.system(size: 50))
                                .fontWeight(.semibold)
                                .padding(.bottom, 90)
                        } else {
                            IndividualBillView(order: selectedOrder!)
                                .environmentObject(billingVM)
                        }
                    }
                    Spacer()
                }
                
                Spacer()
            }
            
            Spacer()
            
            Divider()
                .frame(width: 10)
                .background(.red)
            
            ZStack {
                VStack {
                    Text("Select Table")
                        .fontWeight(.bold)
                        .font(.system(size: 50))
                        .padding(.bottom, 10)
                    
                    Text("Outstanding Bills")
                        .font(.system(size: 30))
                    
                    ScrollView {
                        ForEach(billingVM.billOrders.filter( { $0.status == "served" } ).sorted(by: { Int($0.id!)! < Int($1.id!)! } )) { order in
                                ZStack {
                                    Rectangle()
                                        .frame(width: 360)
                                        .foregroundColor(.white)
                                        .border(.black, width: 1)
                                    
                                    Button(action: {
                                        billingVM.viewingPastBill = false
                                        billingVM.discountInput = "0.00"
                                        selectedOrder = order
                                    }) {
                                        Text("Table \(order.id!)")
                                    }
                                }
                            }
                    }.padding(.horizontal, 20)
                        .frame(width: 360, height: 360)
                        .background(.white)
                    
                    Text("Past Bills")
                    
                    ScrollView {
                        ForEach(billingVM.billsHistory) { bill in
                                ZStack {
                                    Rectangle()
                                        .frame(width: 360)
                                        .foregroundColor(.white)
                                        .border(.black, width: 1)
                                    
                                    Button(action: {
                                        billingVM.discountInput = String(describing: bill.discount)
                                        billingVM.viewingPastBill = true
                                        selectedOrder = bill.order
                                    }) {
                                        Text("\(BillingView.dateFormatter.string(from: bill.billingTime))")
                                    }
                                }
                            }
                    }.padding(.horizontal, 20)
                        .frame(width: 360, height: 360)
                        .background(.white)
                    
                    Spacer()
                    
                }.frame(maxWidth: 400, maxHeight: .infinity)
                    .padding(.top, 20)
                .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .font(.system(size: 30))
            }
        }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
            .navigationBarHidden(true)
            .onAppear {
                billingVM.getOrders()
                billingVM.getBillsHistory()
            }
    }
}

struct BillingView_Previews: PreviewProvider {
    static var previews: some View {
        BillingView().previewInterfaceOrientation(.landscapeLeft)
    }
}

