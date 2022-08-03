//
//  CreateAccountView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 13/5/22.
//

import SwiftUI

struct CreateAccountView: View {
    
    // CreateAccountView uses AuthViewModel
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        if authVM.createAccountSuccess {
            // Once account created, display LoginView
            LoginView()
        } else {
            // Display CreateAccountView
            NavigationView {
                ZStack {
                    VStack {
                        // Title
                        Text("Create Account")
                            .fontWeight(.bold)
                            .font(.system(size: 70))
                        
                        Spacer();
                        
                        // Fail dialogue
                        // ADD: refresh dialogue on second failure
                        if (authVM.createAccountSuccess == false) {
                            Text(authVM.createAccountError)
                                .font(.system(size: 30))
                                .foregroundColor(.red)
                        }
                        
                        HStack {
                            // First name input
                            TextField("First Name", text: $authVM.firstName)
                                .padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .frame(width: 300)
                                .font(.system(size: 40))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .padding(.bottom, 10)
                            
                            // Last name input
                            TextField("Last Name", text: $authVM.lastName)
                                .padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .frame(width: 290)
                                .font(.system(size: 40))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .padding(.bottom, 10)
                        }
                        
                        // Email input
                        TextField("Email", text: $authVM.newEmail)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .font(.system(size: 40))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding(.bottom, 10)
                        
                        // Password input (secure)
                        SecureField("Password", text: $authVM.newPassword)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .font(.system(size: 40))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding(.bottom, 10)
                        
                        // Password verify input (secure)
                        SecureField("Verify password", text: $authVM.verifyPassword)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .font(.system(size: 40))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        
                        // Create account button
                        Button(action: { authVM.createAccount() }) {
                            Image(systemName: "arrow.right.square.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 60))
                                .padding(.top, 20)
                        }
                        
                        Spacer();
                    }
                        .frame(width: 600, height: 800)
                        .background(.white)
                    
                    // Help button
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Link(destination: URL(string: "https://docs.google.com/document/d/1fmndVOoGDhNku8Z8J-9fgqND61m4VME4OHuz0bK8KRA/edit#bookmark=id.943khhlfus1e")!) {
                                Image(systemName: "questionmark.circle.fill")
                                    .font(.system(size: 70))
                            }
                        }.padding(.trailing, 40)
                    }.padding(.bottom, 20)
                }
            }.navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView().previewInterfaceOrientation(.landscapeLeft)
    }
}
