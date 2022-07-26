//
//  IndividualMenuItemView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 8/7/22.
//

import SwiftUI

struct IndividualMenuItemView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    
    let menuItem: MenuItemModel
    
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(data: menuItem.image)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
                .aspectRatio(1, contentMode: .fit)
            
            VStack {
                Spacer()
                
                Text("\(menuItem.id!)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .background(.red)
                    .cornerRadius(2)
                    .padding(.bottom, 35)
            }
            
            if Array(menuItem.status.keys)[0] == "unavailable" {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 30))
                    }.padding(.horizontal, 10)
                    Spacer()
                }.padding(.vertical, 10)
            }
        }
    }
}

struct IndividualMenuItemView_Previews: PreviewProvider {
    static var sampleMenuItem = MenuItemModel(id: "Fried Rice", price: Decimal(7.45), estimatedServingTime: 25, warnings: [], ingredients: ["bread": 2, "eggs": 5], image: UIImage(named: "defaultMenuItemImage")!, status: ["available": []])
    
    static var previews: some View {
        IndividualMenuItemView(menuItem: sampleMenuItem)
            .frame(width: 200, height: 200)
    }
}
