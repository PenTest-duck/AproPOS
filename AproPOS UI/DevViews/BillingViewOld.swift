//
//  BillingView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI

struct BillingViewOld: View {
    var body: some View {
        HStack (spacing: 0) {
            
            VStack {
                Text("Table 14")
                    .font(Font.custom("DIN Bold", size: 60))
                    
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(.black, lineWidth: 2)
                        .frame(width: 860, height: 700)
                        .padding(.leading, 30)
                    
                    Text("$16.70")
                        .font(.system(size: 30))
                        .offset(x: 340, y: 82)
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        Text("Order summary")
                            .fontWeight(.bold)
                            .font(.system(size: 40))
                            .offset(x: -210, y: 90)
                        
                        Group {
                            Text("$12.00")
                            Text("$33.00")
                            Text("$32.00\n")
                            Text("$21.00")
                            Text("$54.00")
                            Text("\n$15.00").offset(y: 30)
     
                        }.offset(x: 450, y: 115)
                    
                        
                        Group {
                            Text("1  Garlic Mashed Potato  _____________________")
                            HStack {
                                Text("2  Spaghetti Carbonara  _____________________")
                            }
                            VStack(alignment: .leading) {
                                Text("1  New York Strip  __________________________")
                                Text("     Medium")
                                    .foregroundColor(.gray)
                            }
                            Text("1  Chicken Schnitzel  ________________________")
                            VStack(alignment: .leading) {
                                Text("2  Sirloin Steak  ____________________________")
                                Text("     Well done")
                                    .foregroundColor(.gray)
                                Text("     Medium Rare")
                                    .foregroundColor(.gray)
                            }
                            Text("1  Red Wine  _______________________________")
                            Text("    10% Discount   ___________________________").foregroundColor(.blue)
                            
                            Group {
                                Text("\nSub Total:   $167.00")
                                    .foregroundColor(Color.orange)
                                    .fontWeight(.bold).offset(x: 485)
                                Text("Reductions:   $16.70")
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.bold).offset(x: 455)
                                Text("Total:   $150.30")
                                    .foregroundColor(Color.red)
                                    .fontWeight(.bold).offset(x: 547)
                            }.offset(y: 20)
                        }.offset(x: -210, y: -180)
                        
                        
                    }.font(.system(size: 30))
                        .offset(x: 170)
                }
                
                Spacer()
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

struct BillingViewOld_Previews: PreviewProvider {
    static var previews: some View {
        BillingViewOld()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
