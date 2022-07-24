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
            VStack (spacing: 0) {
                HStack (spacing: 0) {
                    NavigationLink(destination: MenuView()) {
                        Text("Menu")
                            .font(Font.custom("DIN Bold", size: 100))
                            .foregroundColor(Color.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 210/255, green: 150/255, blue: 180/255))
                    
                    NavigationLink(destination: InventoryView()) {
                        Text("Inventory")
                            .font(Font.custom("DIN Bold", size: 100))
                            .foregroundColor(Color.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 40/255, green: 140/255, blue: 60/255))
                }
                
                HStack (spacing: 0) {
                    if !staffVM.disallowedViews.contains("StaffView") {
                        NavigationLink(destination: StaffView()) {
                            Text("Staff")
                                .font(Font.custom("DIN Bold", size: 100))
                                .foregroundColor(Color.white)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 90/255, green: 40/255, blue: 200/255))
                    } else {
                        ZStack {
                            Text("Staff")
                                .font(Font.custom("DIN Bold", size: 100))
                                .foregroundColor(Color.white)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                            
                            Image(systemName: "lock.fill")
                                .font(.system(size: 180))
                                .foregroundColor(.red)
                                .opacity(0.8)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 90/255, green: 40/255, blue: 200/255))
                    }
                    
                    if !staffVM.disallowedViews.contains("AnalyticsView") {
                        NavigationLink(destination: StaffView()) {
                            Text("Analytics")
                                .font(Font.custom("DIN Bold", size: 100))
                                .foregroundColor(Color.white)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 160/255, green: 50/255, blue: 80/255))
                    } else {
                        ZStack {
                            Text("Analytics")
                                .font(Font.custom("DIN Bold", size: 100))
                                .foregroundColor(Color.white)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                            
                            Image(systemName: "lock.fill")
                                .font(.system(size: 180))
                                .foregroundColor(.red)
                                .opacity(0.8)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 160/255, green: 50/255, blue: 80/255))
                    }
                }
            }.ignoresSafeArea()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ManagementView_Previews: PreviewProvider {
    static var previews: some View {
        ManagementView().previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(StaffViewModel())
    }
}
