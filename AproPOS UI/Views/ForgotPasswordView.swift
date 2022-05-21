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
            LoginView()
        } else {
            NavigationView {
                VStack {
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
                    
                    TextField(" Email", text: $authVM.resetPasswordEmail)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.system(size: 40))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .padding(.bottom, 10)
                    
                    Button(action: { authVM.resetPassword() }) {
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

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView().previewInterfaceOrientation(.landscapeLeft)
    }
}
