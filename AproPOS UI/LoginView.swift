//
//  LoginView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 15/3/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginVM = LoginViewModel();
    
    var body: some View {
        
        if loginVM.isLoggedIn {
            MainView()
        } else {
            NavigationView {
                VStack {
                    Text("AproPOS")
                        .fontWeight(.bold)
                        .font(.system(size: 50))
                    
                    TextField(" Email", text: $loginVM.email)
                        .font(.system(size: 40))
                        .border(.black)
                        .padding(.bottom, 10)
                    
                    SecureField(" Password", text: $loginVM.password)
                        .font(.system(size: 40))
                        .border(.black)
                    
                    // Fail login dialogue
                    // ADD: refresh dialogue on second failure
                    if loginVM.failedLogin {
                        Text("Invalid login, please try again.")
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                    }
                    
                    Button(action: { loginVM.login() }) {
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().previewInterfaceOrientation(.landscapeLeft)
    }
}
