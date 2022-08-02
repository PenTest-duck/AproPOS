//
//  MainView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var staffVM = StaffViewModel()
    //@StateObject private var authVM = AuthViewModel()
    @EnvironmentObject var authVM: AuthViewModel
            
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 0) {
                    HStack (spacing: 0) {
                        NavigationLink(destination: OrderView()) {
                            Text("Order")
                                .font(Font.custom("DIN Bold", size: 100))
                                .foregroundColor(Color.white)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 237/255, green: 106/255, blue: 90/255))
                        
                        NavigationLink(destination: BillingView()) {
                            Text("Billing")
                                .font(Font.custom("DIN Bold", size: 100))
                                .foregroundColor(Color.white)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(red: 160/255, green: 236/255, blue: 208/255))
                    }
                    
                    HStack (spacing: 0) {
                        ZStack {
                            NavigationLink(destination: TableView()) {
                                Text("Tables")
                                    .font(Font.custom("DIN Bold", size: 100))
                                    .foregroundColor(Color.white)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(red: 202/255, green: 85/255, blue: 220/255))
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Button(action: {
                                        authVM.logout()
                                        authVM.isLoggedIn = false
                                    }) {
                                        Text("Logout")
                                            .font(.system(size: 30))
                                            .foregroundColor(.white)
                                            .underline()
                                    }
                                    Spacer()
                                }.padding(.leading, 30)
                            }.padding(.bottom, 30)
                        }
                        
                        if !staffVM.disallowedViews.contains("ManagementView") {
                            NavigationLink(destination: ManagementView().environmentObject(staffVM)) {
                                ZStack {
                                    Text("Management")
                                        .font(Font.custom("DIN Bold", size: 100))
                                        .foregroundColor(Color.white)
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(red: 8/255, green: 61/255, blue: 119/255))
                        } else {
                            ZStack {
                                Text("Management")
                                    .font(Font.custom("DIN Bold", size: 100))
                                    .foregroundColor(Color.white)
                                
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 180))
                                    .foregroundColor(.red)
                                    .opacity(0.8)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(red: 8/255, green: 61/255, blue: 119/255))
                        }
                    }
                }.ignoresSafeArea()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
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
            .navigationBarBackButtonHidden(true)
            .onAppear {
                staffVM.getUsers()
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AuthViewModel())
    }
}
