//
//  IndividualOrderView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 28/2/22.
//

import SwiftUI

struct IndividualOrderView: View {
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
              startPoint: .init(x: 0, y: 0),
              endPoint: .init(x: 1, y: 1)
            ))
            .frame(width: 600, height: 400)
            .cornerRadius(50)
    }
}

struct IndividualOrderView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualOrderView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
