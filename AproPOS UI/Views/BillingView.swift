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
    
    @State private var confirmingDelete: Bool = false
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy h:mm a"
        return formatter
    }()
        
    var body: some View {
        ZStack {
            HStack (spacing: 0) {
                VStack {
                    VStack {
                        ZStack {
                            HStack {
                                Text("Billing")
                                    .font(.system(size: 60))
                                    .fontWeight(.bold)
                            }
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        ZStack {
                            if billingVM.selectedOrder == nil {
                                Text("Select a bill to view")
                                    .font(.system(size: 50))
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 90)
                            } else {
                                IndividualBillView(order: billingVM.selectedOrder!)
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
                    .background(Color(red: 202/255, green: 85/255, blue: 220/255))
                
                ZStack {
                    VStack {
                        Text("Select Bill")
                            .fontWeight(.bold)
                            .font(.system(size: 50))
                            .padding(.bottom, 10)
                        
                        Text("Outstanding Bills")
                            .font(.system(size: 30))
                        
                        ScrollView {
                            ForEach(billingVM.billOrders.filter( { $0.status == "served" } ).sorted(by: { Int($0.id!)! < Int($1.id!)! } )) { order in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 1)
                                            .frame(width: 360)
                                            .foregroundColor(.white)
                                        
                                        Button(action: {
                                            billingVM.viewingPastBill = false
                                            billingVM.discountInput = "0.00"
                                            billingVM.selectedOrder = order
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
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 1)
                                            .frame(width: 360)
                                            .foregroundColor(.white)
                                        
                                        Button(action: {
                                            billingVM.discountInput = String(describing: bill.discount)
                                            billingVM.viewingPastBill = true
                                            billingVM.selectedOrder = bill.order
                                            billingVM.server = bill.server
                                        }) {
                                            Text("\(BillingView.dateFormatter.string(from: bill.billingTime))")
                                        }
                                    }
                                }
                        }.padding(.horizontal, 20)
                            .frame(width: 360, height: 320)
                            .background(.white)
                        
                        Spacer()
                        
                    }.frame(maxWidth: 400, maxHeight: .infinity)
                        .padding(.top, 20)
                    .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                    .font(.system(size: 30))
                }
            }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
                //.navigationBarHidden(true)
                .onAppear {
                    billingVM.getOrders()
                    billingVM.getBillsHistory()
                    billingVM.getUsers()
                }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Link(destination: URL(string: "https://docs.google.com/document/d/1fmndVOoGDhNku8Z8J-9fgqND61m4VME4OHuz0bK8KRA/edit#bookmark=id.iw3dn7mc99d9")!) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 40))
                    }
                }.padding(.trailing, 20)
                
                Spacer()
            }.padding(.top, 25)
        }
    }
}

struct BillingView_Previews: PreviewProvider {
    static var previews: some View {
        BillingView().previewInterfaceOrientation(.landscapeLeft)
    }
}

