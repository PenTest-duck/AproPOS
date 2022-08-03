//
//  LoginView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 15/3/22.
//

import SwiftUI

struct LoginView: View {
    
    // LoginView uses StaffViewModel and AuthViewModel
    @StateObject private var staffVM = StaffViewModel()
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        
        return Group { // Returning Group allows switching between MainView and LoginView
            if authVM.isLoggedIn {
                // If logged in, display MainView
                MainView().environmentObject(authVM)
            } else {
                // If not logged in, display LoginView
                NavigationView {
                    ZStack {
                        VStack {
                            // Title
                            Text("AproPOS")
                                .fontWeight(.bold)
                                .font(.system(size: 70))
                            
                            Spacer()
                            
                            HStack {
                                // Create account button
                                NavigationLink(destination: CreateAccountView().onAppear {
                                    // Clear authVM input fields
                                    authVM.email = ""
                                    authVM.password = ""
                                }) {
                                    Text("Create Account")
                                        .underline()
                                        .font(.system(size: 30))
                                        .navigationBarHidden(true)
                                }
                                
                                // Forgot password button
                                NavigationLink(destination: ForgotPasswordView().onAppear {
                                    // Clear authVM input fields
                                    authVM.email = ""
                                    authVM.password = ""
                                }) {
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
                            
                            // Email input
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
                            
                            // Password input (secure)
                            SecureField("Password", text: $authVM.password)
                                .padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .font(.system(size: 40))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                            
                            // Login button
                            Button(action: {
                                // Clear authVM values so that input fields are not pre-populated upon logout
                                authVM.login()
                                authVM.email = ""
                                authVM.password = ""
                                authVM.failedLogin = false
                                authVM.loginError = ""
                            }) {
                                Image(systemName: "arrow.right.square.fill")
                                    .foregroundColor(Color.blue)
                                    .font(.system(size: 60))
                                    .padding(.top, 20)
                            }
                            
                            Spacer();
                            
                        }.frame(width: 450, height: 800)
                            .background(.white)
                        
                        // Help button
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Link(destination: URL(string: "https://docs.google.com/document/d/1fmndVOoGDhNku8Z8J-9fgqND61m4VME4OHuz0bK8KRA/edit#bookmark=id.jj0fm58hx5ed")!) {
                                    Image(systemName: "questionmark.circle.fill")
                                        .font(.system(size: 70))
                                }
                            }.padding(.trailing, 40)
                        }.padding(.bottom, 20)
                    }
                }.navigationViewStyle(StackNavigationViewStyle())
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().previewInterfaceOrientation(.landscapeLeft)
    }
}
