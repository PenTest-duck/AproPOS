//
//  ForgotPasswordView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 20/5/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        
        if authVM.resetPasswordSuccess {
            // Once password has been reset, return to login view
            LoginView()
        } else {
            // Display ForgotPasswordView
            NavigationView {
                ZStack {
                    VStack {
                        // Title
                        Text("AproPOS")
                            .fontWeight(.bold)
                            .font(.system(size: 70))
                        
                        Spacer();
                        
                        // Fail reste password dialogue
                        // ADD: refresh dialogue on second failure
                        if (authVM.resetPasswordSuccess == false) {
                            Text(authVM.resetPasswordError)
                                .font(.system(size: 30))
                                .foregroundColor(.red)
                        }
                        
                        Text("Reset Password")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                        
                        // Email input
                        TextField("Email", text: $authVM.resetPasswordEmail)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .font(.system(size: 40))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding(.bottom, 10)
                        
                        // Password reset button
                        // Will send a templated email to user for resetting password
                        Button(action: { authVM.resetPassword() }) {
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
                            Link(destination: URL(string: "https://docs.google.com/document/d/1fmndVOoGDhNku8Z8J-9fgqND61m4VME4OHuz0bK8KRA/edit#bookmark=id.jxv01uosff4d")!) {
                                Image(systemName: "questionmark.circle.fill")
                                    .font(.system(size: 70))
                            }
                        }.padding(.trailing, 40)
                    }.padding(.bottom, 20)
                }
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView().previewInterfaceOrientation(.landscapeLeft)
    }
}
