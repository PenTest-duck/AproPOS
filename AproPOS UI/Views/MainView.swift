//
//  MainView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var staffVM = StaffViewModel()
    
    @State private var ManagementViewAllowed: Bool = false
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                HStack (spacing: 0) {
                    NavigationLink(destination: OrderView()) {
                        Text("Order")
                            .font(Font.custom("DIN Bold", size: 100))
                            .foregroundColor(Color.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 237/255, green: 106/255, blue: 90/255))
                    
                    NavigationLink(destination: BillingView()) {
                        Text("Billing")
                            .font(Font.custom("DIN Bold", size: 100))
                            .foregroundColor(Color.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 160/255, green: 236/255, blue: 208/255))
                }
                
                HStack (spacing: 0) {
                    NavigationLink(destination: TableView()) {
                        Text("Tables")
                            .font(Font.custom("DIN Bold", size: 100))
                            .foregroundColor(Color.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 202/255, green: 85/255, blue: 220/255))
                    
                    if !staffVM.disallowedViews.contains("ManagementView") {
                        NavigationLink(destination: ManagementView()) {
                            ZStack {
                                Text("Management")
                                    .font(Font.custom("DIN Bold", size: 100))
                                    .foregroundColor(Color.white)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 8/255, green: 61/255, blue: 119/255))
                    } else {
                        ZStack {
                            Text("Management")
                                .font(Font.custom("DIN Bold", size: 100))
                                .foregroundColor(Color.white)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                            
                            Image(systemName: "lock.fill")
                                .font(.system(size: 180))
                                .foregroundColor(.red)
                                .opacity(0.8)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 8/255, green: 61/255, blue: 119/255))
                    }
                }
            }.ignoresSafeArea()
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .onAppear {
                staffVM.getUsers()
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewInterfaceOrientation(.landscapeLeft)
    }
}
