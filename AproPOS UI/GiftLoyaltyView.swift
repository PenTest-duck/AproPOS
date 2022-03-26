//
//  GiftLoyaltyView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI

struct CardView: View {
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
    var body: some View {
        ZStack(alignment: .leading) {

            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                  startPoint: .init(x: 0, y: 0),
                  endPoint: .init(x: 1, y: 1)
                ))
                //.frame(height: 180)
                .cornerRadius(15)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Gift Card")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                        .shadow(radius: 1)
                    
                    Spacer()
                    
                    ZStack {
                        Image(systemName: "heart.fill")
                    }
                    .font(.title2)
                    .foregroundColor(.red)
                    .padding(.trailing, 20)
                    
                }.padding(.top, 40)
                
                Text("Job")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                    .padding(.leading, 20)
                    .padding(.top, -10)
             
                Text("Organisation")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                    .padding(.leading, 20)
                
                Text("PH:  phone")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    .padding(.leading, 20)
                    .padding(.top, 10)
                
                Text("Email:  email")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    .padding(.leading, 20)
                
            }.offset(y: -23)
            
            NavigationLink("Edit", destination: GiftLoyaltyView())
                .opacity(0)
                
            
        }
        .shadow(radius: 5)
    }
    
}

struct GiftLoyaltyView: View {
    var body: some View {
        HStack(spacing: 0) {
            
            VStack {
                CardView()
                    .frame(width: 400, height: 200)
            }
            
            Spacer()
            
            VStack {
                
                Text("Gift & Loyalty")
                    .font(Font.custom("DIN Bold", size: 60))
                    .padding(.bottom, 100)
                
                ZStack {
                    Rectangle()
                        .cornerRadius(30)
                        .foregroundColor(Color.blue)
                        .frame(width: 380, height: 100)
                        .padding(.bottom, 10)
                    
                    Text("Save Layout")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .font(.system(size: 35))
                }.padding(.top, -30)
                
            }.frame(maxWidth: 450, maxHeight: .infinity)
                .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .font(.system(size: 30))
        }
    }
}

struct GiftLoyaltyView_Previews: PreviewProvider {
    static var previews: some View {
        GiftLoyaltyView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
