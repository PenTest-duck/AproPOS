//
//  LoginViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 13/5/22.
//

import Foundation
import Firebase

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var failedLogin = false
    
    // Verify login with Firebase
    // From https://designcode.io/swiftui-advanced-handbook-firebase-auth
    func login() {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "") // debugging purposes
                self.failedLogin = true
            } else {
                print("success") // debugging purposes
                self.isLoggedIn = true
            }
        }
    }
}


