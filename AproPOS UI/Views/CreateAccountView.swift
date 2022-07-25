//
//  CreateAccountView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 13/5/22.
//

import SwiftUI

struct CreateAccountView: View {
    
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        
        if authVM.createAccountSuccess {
            LoginView()
        } else {
            
            NavigationView {
                VStack {
                    Text("AproPOS")
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
                    
                    SecureField("Verify password", text: $authVM.verifyPassword)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.system(size: 40))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
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
            }.navigationViewStyle(StackNavigationViewStyle())
                //.navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView().previewInterfaceOrientation(.landscapeLeft)
    }
}
