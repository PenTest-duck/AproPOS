//
//  LoginView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 15/3/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var usernameInput = ""
    @State private var passwordInput = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("AproPOS Login")
                    .fontWeight(.bold)
                    .font(.system(size: 50))
                
                TextField(" Username", text: $usernameInput)
                    .font(.system(size: 40))
                    .border(.black)
                    .padding(.bottom, 10)
                SecureField(" Password", text: $passwordInput)
                    .font(.system(size: 40))
                    .border(.black)
                
                NavigationLink(destination: MainView()) {
                    Image(systemName: "arrow.right.square.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 60))
                        .padding(.top, 20)
                }
            }
                .frame(width: 400, height: 200)
                .background(.white)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().previewInterfaceOrientation(.landscapeLeft)
    }
}
