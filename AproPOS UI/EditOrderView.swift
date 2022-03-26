//
//  EditOrderView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 7/3/22.
//

import SwiftUI

struct EditOrderView: View {
    
    @State var textInput: String = ""
    
    var body: some View {
        VStack {
            Text("Order list")
                .font(.system(size: 100))
                .fontWeight(.bold)
            TextField("Caesar Salad", text: $textInput)
                .frame(width: 500, height: 40)
        }
    }
}

struct EditOrderView_Previews: PreviewProvider {
    static var previews: some View {
        EditOrderView().previewInterfaceOrientation(.landscapeLeft)
    }
}
