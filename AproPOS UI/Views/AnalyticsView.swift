//
//  AnalyticsView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 4/8/22.
//

import SwiftUI

struct AnalyticsView: View {
    @StateObject private var analyticsVM = AnalyticsViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Analytics")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                }
                Spacer()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Menu Items Sorted By Popularity")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                        .padding(.top, 15)
                    
                    List {
                        ForEach(analyticsVM.sortedMenuItemStatistics, id: \.0) { menuItem in
                            HStack {
                                Text("\(menuItem.0)")
                                
                                Spacer()
                                
                                Text("\(menuItem.1)")
                                
                            }.listRowBackground(Color(red: 242/255, green: 242/255, blue: 248/255))
                                .padding(.horizontal, 20)
                        }
                    }.listStyle(PlainListStyle())
                        .padding(.horizontal, 20)
                }
            }.frame(width: 1200, height: 700)
        }.navigationBarHidden(true)
        .onAppear {
            analyticsVM.sortMenuItemsByPopularity()
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView().previewInterfaceOrientation(.landscapeLeft)
    }
}
