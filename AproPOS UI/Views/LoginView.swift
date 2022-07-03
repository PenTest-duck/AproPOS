//
//  LoginView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 15/3/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        
        if authVM.isLoggedIn {
            MainView()
        } else {
            NavigationView {
                VStack {
                    Text("AproPOS")
                        .fontWeight(.bold)
                        .font(.system(size: 70))
                    
                    Spacer();
                    
                    // Button to be styled
                    HStack {
                        NavigationLink(destination: CreateAccountView()) {
                            Text("Create Account")
                                .underline()
                                .font(.system(size: 30))
                                .navigationBarHidden(true)
                        }
                        
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot Password")
                                .underline()
                                .font(.system(size: 30))
                                .navigationBarHidden(true)
                        }
                    }
                    
                    // Fail login dialogue
                    // ADD: refresh dialogue on second failure
                    if authVM.failedLogin {
                        Text(authVM.loginError)
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                    }
                    
                    TextField("Email", text: $authVM.email)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.system(size: 40))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .padding(.bottom, 10)
                    
                    SecureField("Password", text: $authVM.password)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.system(size: 40))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    Button(action: { authVM.login() }) {
                        Image(systemName: "arrow.right.square.fill")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 60))
                            .padding(.top, 20)
                    }
                    
                    Spacer();
                }
                    .frame(width: 450, height: 800)
                    .background(.white)
            }.navigationViewStyle(StackNavigationViewStyle())
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().previewInterfaceOrientation(.landscapeLeft)
    }
}
