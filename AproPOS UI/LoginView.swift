//
//  LoginView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 15/3/22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var isLoggedIn = false
    @State private var failedLogin = false
    
    var body: some View {
        
        if isLoggedIn {
            MainView()
        } else {
            NavigationView {
                VStack {
                    Text("AproPOS Login")
                        .fontWeight(.bold)
                        .font(.system(size: 50))
                    
                    TextField(" Email", text: $email)
                        .font(.system(size: 40))
                        .border(.black)
                        .padding(.bottom, 10)
                    
                    SecureField(" Password", text: $password)
                        .font(.system(size: 40))
                        .border(.black)
                    
                    if failedLogin {
                        Text("Invalid login, please try again.")
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                    }
                    
                    Button(action: { login() }) {
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
    
    // Verify login with Firebase
    // From https://designcode.io/swiftui-advanced-handbook-firebase-auth
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "") // debugging purposes
                failedLogin = true
            } else {
                print("success") // debugging purposes
                isLoggedIn = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().previewInterfaceOrientation(.landscapeLeft)
    }
}
