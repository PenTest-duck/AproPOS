//
//  LoginViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 13/5/22.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

final class AuthViewModel: ObservableObject {
    
    // Repository
    @Published var userRepository = UserRepository()
    
    // Login input fields
    @Published var email = ""
    @Published var password = ""
    
    // Login system fields
    @Published var isLoggedIn = false
    @Published var failedLogin = false
    
    // Login error field
    @Published var loginError = ""
    
    // Create account input fields
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var newEmail = ""
    @Published var newPassword = ""
    @Published var verifyPassword = ""
    
    // Create account system fields
    @Published var createAccountSuccess = false
    
    // Create account error field
    @Published var createAccountError = ""
    
    // Reset password input field
    @Published var resetPasswordEmail = ""
    
    // Reset password system field
    @Published var resetPasswordSuccess = false
    
    // Reset password error field
    @Published var resetPasswordError = ""
    
    // Verify login with Firebase Auth
    // From https://designcode.io/swiftui-advanced-handbook-firebase-auth
    func login() {
        // Sign into Firebase Auth
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
            // Error handling
            if (error != nil) {
                self.loginError = error?.localizedDescription ?? ""
                self.failedLogin = true
            } else {
                self.isLoggedIn = true
            }
        }
    }
    
    // Log out of current user
    func logout() {
        do {
            try Auth.auth().signOut()
            
        // Error handling
        } catch {
            print("Failed to logout")
        }
    }
    
    // Create a new user account
    func createAccount() {
        
        createAccountSuccess = false
        
        if (firstName == "" || lastName == "" || newEmail == "" || newPassword == "" || verifyPassword == "") { // Check if any fields are empty
            createAccountError = "Please fill in all fields"
        } else if ( !isValidEmail(newEmail) ) { // Check if email address is in a valid format
            createAccountError = "Please provide a valid email address"
        } else if (newPassword != verifyPassword) { // Check both password inputs match
            createAccountError = "Passwords don't match"
        } else {
            // Create account on Firebase Auth
            Auth.auth().createUser(withEmail: newEmail, password: newPassword) { (result, error) in
                // Error handling
                if (error != nil) {
                    self.createAccountError = error?.localizedDescription ?? ""
                    return
                }
            }
            
            // Create new UserModel
            let newUser = UserModel(id: newEmail, firstName: firstName, lastName: lastName)
            
            // Add user to database
            let createUserResult = userRepository.addUser(user: newUser)
            
            // Set successes and errors
            if createUserResult == "success" {
                self.createAccountSuccess = true
            } else {
                self.createAccountError = createUserResult
            }
        }
    }
    
    // Check if email input is a valid email address
    // From https://medium.com/@darthpelo/email-validation-in-swift-3-0-acfebe4d879a
    func isValidEmail(_ email: String) -> Bool {
        // Email format regex
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        // Check if email conforms to regex
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // Send a reset password email
    func resetPassword() {
        // Sends an automatic email to user for password reset prompt
        Auth.auth().sendPasswordReset(withEmail: resetPasswordEmail) { error in
            // Error handling
            if (error != nil) {
                self.resetPasswordSuccess = false
                self.resetPasswordError = error?.localizedDescription ?? ""
            } else {
                self.resetPasswordSuccess = true
            }
        }
    }
}


