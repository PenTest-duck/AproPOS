//
//  MainView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI

struct MainView: View {
    
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
                        .background(Color(red: 246/255, green: 188/255, blue: 71/255))
                    
                    NavigationLink(destination: BillingView2()) {
                        Text("Billing")
                            .font(Font.custom("DIN Bold", size: 100))
                            .foregroundColor(Color.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 105/255, green: 191/255, blue: 182/255))
                            
                }
                
                HStack (spacing: 0) {
                    NavigationLink(destination: ReservationView()) {
                        Text("Reservations")
                            .font(Font.custom("DIN Bold", size: 100))
                            .foregroundColor(Color.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 0.5, green: 0.375, blue: 0.77))
                    
                    NavigationLink(destination: ManagementView()) {
                        Text("Management")
                            .font(Font.custom("DIN Bold", size: 100))
                            .foregroundColor(Color.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 110/255, green: 179/255, blue: 90/255))
                }
            }.ignoresSafeArea()
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewInterfaceOrientation(.landscapeLeft)
    }
}
