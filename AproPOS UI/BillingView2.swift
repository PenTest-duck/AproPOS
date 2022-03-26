//
//  BillingView2.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 9/3/22.
//

import SwiftUI

struct BillingView2: View {
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                Image("order-summary-2")
                    .resizable()
                    .frame(width: 870)
                    .padding(.leading, 25)
                
                ZStack {
                    Rectangle()
                        .cornerRadius(30)
                        .foregroundColor(.green)
                        .frame(width: 260, height: 65)
                        .padding(.bottom, 10)
                    
                    Text("Reductions")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .font(.system(size: 35))
                }.offset(x: -230, y: 350)
            }
            
            
            Spacer()
            
            VStack {
                Text("Billing")
                    .font(Font.custom("DIN Bold", size: 60))
            
                List {
                    Group {
                        Text("Table 2")
                            .fontWeight(.semibold)
                            .frame(height: 60)
                        Text("Table 4")
                            .fontWeight(.semibold)
                            .frame(height: 60)
                        Text("Table 7")
                            .fontWeight(.semibold)
                            .frame(height: 60)
                        Text("Table 8")
                            .fontWeight(.semibold)
                            .frame(height: 60)
                    }.offset(x: 140)
                    
                    Group {
                        Text("Table 11")
                            .fontWeight(.semibold)
                            .frame(height: 60)
                        Text("Table 12")
                            .fontWeight(.semibold)
                            .frame(height: 60)
                        Text("Table 14")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(height: 60)
                            .listRowBackground(Color.blue)
                        Text("Table 17")
                            .fontWeight(.semibold)
                            .frame(height: 60)
                    }.offset(x: 135)
                    
                }.listStyle(InsetGroupedListStyle())
                    .padding(5)
                    .padding(.top, -40)
                
                ZStack {
                    Rectangle()
                        .cornerRadius(30)
                        .foregroundColor(Color.blue)
                        .frame(width: 380, height: 100)
                        .padding(.bottom, 10)
                    
                    Text("Process Payment")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .font(.system(size: 35))
                }
                
            }.frame(maxWidth: 450, maxHeight: .infinity)
            .background(Color(red: 242/255, green: 242/255, blue: 248/255))
            .font(.system(size: 30))
            
        }//.navigationBarHidden(true)
    }
}

struct BillingView2_Previews: PreviewProvider {
    static var previews: some View {
        BillingView2().previewInterfaceOrientation(.landscapeLeft)
    }
}
