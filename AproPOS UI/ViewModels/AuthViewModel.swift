//
//  LoginViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 13/5/22.
//

import Foundation
import Firebase
import FirebaseFirestore

final class AuthViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var failedLogin = false
    @Published var loginError = "" // Contains login error message
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var newEmail = ""
    @Published var newPassword = ""
    @Published var verifyPassword = ""
    //@Published var securityQuestion = ""
    //@Published var securityAnswer = ""
    @Published var createAccountSuccess = false
    @Published var createAccountError = "" // Contains create account error message
    
    @Published var resetPasswordEmail = ""
    @Published var resetPasswordSuccess = false
    @Published var resetPasswordError = ""
    
    // Verify login with Firebase
    // From https://designcode.io/swiftui-advanced-handbook-firebase-auth
    func login() {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
            if (error != nil) {
                self.loginError = error?.localizedDescription ?? ""
                self.failedLogin = true
            } else {
                self.isLoggedIn = true
            }
        }
    }
    
    // Create new user account
    func createAccount() {
        
        // Check no fields are empty
        if (self.firstName == "" || self.lastName == "" || self.newEmail == "" || self.newPassword == "" || self.verifyPassword == "") {
            self.createAccountSuccess = false
            self.createAccountError = "Please fill in all fields."
            return
        }
        
        // Check email address is valid
        if ( !isValidEmail(self.newEmail) ) {
            self.createAccountSuccess = false
            self.createAccountError = "Please provide a valid email address."
            return
        }
        
        // Check both password inputs match
        if (self.newPassword != self.verifyPassword) {
            self.createAccountSuccess = false
            self.createAccountError = "Passwords don't match."
            return
        }
        
        // Create account on Firebase
        Auth.auth().createUser(withEmail: newEmail, password: newPassword) { (result, error) in
            if (error != nil) {
                self.createAccountSuccess = false
                self.createAccountError = error?.localizedDescription ?? ""
                return
            }
        }
        
        createFirestoreUser()
    }
    
    // Check if email input is a valid email address
    // From https://medium.com/@darthpelo/email-validation-in-swift-3-0-acfebe4d879a
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // Send a reset password email
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: resetPasswordEmail) { error in
            if (error != nil) {
                self.resetPasswordSuccess = false
                self.resetPasswordError = error?.localizedDescription ?? ""
            } else {
                self.resetPasswordSuccess = true
            }
        }
    }
    
    // Create user document on Firestore
    // From: https://designcode.io/swiftui-advanced-handbook-write-to-firestore
    func createFirestoreUser() {
        let userDocRef = db.collection("users").document(newEmail)
        let userDocData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "role": "staff"
        ]
        
        userDocRef.setData(userDocData) { error in
            if (error != nil) {
                self.createAccountError = error?.localizedDescription ?? ""
            } else {
                self.createAccountSuccess = true
            }
        }
    }
}


