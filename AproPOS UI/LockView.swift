//
//  LockView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 25/2/22.
//

import SwiftUI

struct LockView: View {
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                Text("Password")
            }.ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LockView_Previews: PreviewProvider {
    static var previews: some View {
        LockView().previewInterfaceOrientation(.landscapeLeft)
    }
}
