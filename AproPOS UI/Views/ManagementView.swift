//
//  ManagementView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 25/2/22.
//

import SwiftUI

struct ManagementView: View {
    
    @EnvironmentObject var staffVM: StaffViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 0) {
                    HStack (spacing: 0) {
                        // Link to menu system
                        NavigationLink(destination: MenuView()) {
                            Text("Menu")
                                .font(Font.custom("DIN Bold", size: 100))
                                .foregroundColor(Color.white)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 123/255, green: 30/255, blue: 122/255))
                        
                        // Link to inventory system
                        NavigationLink(destination: InventoryView()) {
                            Text("Inventory")
                                .font(Font.custom("DIN Bold", size: 100))
                                .foregroundColor(Color.white)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 67/255, green: 170/255, blue: 139/255))
                    }
                    
                    HStack (spacing: 0) {
                        if !staffVM.disallowedViews.contains("StaffView") { // If allowed in StaffView
                            // Link to staff system
                            NavigationLink(destination: StaffView()) {
                                Text("Staff")
                                    .font(Font.custom("DIN Bold", size: 100))
                                    .foregroundColor(Color.white)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(red: 179/255, green: 63/255, blue: 98/255))
                        } else { // If not allowed in StaffView
                            ZStack {
                                Text("Staff")
                                    .font(Font.custom("DIN Bold", size: 100))
                                    .foregroundColor(Color.white)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                                
                                // Lock symbol
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 180))
                                    .foregroundColor(.red)
                                    .opacity(0.8)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(red: 179/255, green: 63/255, blue: 98/255))
                        }
                        
                        if !staffVM.disallowedViews.contains("AnalyticsView") { // If allowed in AnalyticsView
                            // Link to analytics system
                            NavigationLink(destination: AnalyticsView()) {
                                Text("Analytics")
                                    .font(Font.custom("DIN Bold", size: 100))
                                    .foregroundColor(Color.white)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(red: 12/255, green: 10/255, blue: 62/255))
                        } else { // If not allowed in AnalyticsView
                            ZStack {
                                Text("Analytics")
                                    .font(Font.custom("DIN Bold", size: 100))
                                    .foregroundColor(Color.white)
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                                
                                // Lock symbol
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 180))
                                    .foregroundColor(.red)
                                    .opacity(0.8)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(red: 12/255, green: 10/255, blue: 62/255))
                        }
                    }
                }.ignoresSafeArea()
                
                // Help button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Link(destination: URL(string: "https://docs.google.com/document/d/1fmndVOoGDhNku8Z8J-9fgqND61m4VME4OHuz0bK8KRA/edit#bookmark=id.ren43qxael4u")!) {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.system(size: 70))
                        }
                    }.padding(.trailing, 40)
                }.padding(.bottom, 20)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ManagementView_Previews: PreviewProvider {
    static var previews: some View {
        ManagementView().previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(StaffViewModel())
    }
}
