//
//  StaffViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 5/7/22.
//

import Foundation
import FirebaseAuth

final class StaffViewModel: ObservableObject {
    // Repository and storage
    @Published var users = [UserModel]()
    @Published var userRepository = UserRepository()
    
    // Error field
    @Published var error = ""
    
    // Input fields
    @Published var emailInput: String = ""
    @Published var firstNameInput: String = ""
    @Published var lastNameInput: String = ""
    @Published var roleInput: String = ""
    @Published var wageInput: String = "0.00"
    @Published var phoneInput: String = ""
    @Published var commentInput: String = ""
    
    // System field for editing user email address
    @Published var oldEmailInput: String = ""
    
    // RBAC
    @Published var disallowedViews: [String] = []
    
    // Validates input fields
    func validateInput() {
        if emailInput == "" { // Check if email is empty
            error = "Please enter an email address"
        } else if firstNameInput == "" || lastNameInput == "" { // Check if first or last name is empty
            error = "Please enter the first and last name"
        } else if !AuthViewModel().isValidEmail(emailInput) { // Check if email is in an invalid format
            error = "Invalid email address"
        } else if (wageInput.filter { $0 == "." }).count >= 2 { // Check if wage contains more than one decimal point
            error = "Invalid wage"
        } else if wageInput[(wageInput.firstIndex(of: ".") ?? wageInput.index(wageInput.endIndex, offsetBy: -1))...].count > 3 { // Check if wage contains more than two decimal digits
            error = "Currency allows max. 2 decimal places"
        } else if Double(wageInput)! == 0 { // Check if wage is zero
            error = "Wage cannot be zero"
        } else {
            error = ""
        }
    }
    
    // Retrieves all users and stores them in <users>
    // Can be run once, and will asynchronously update if there are changes to the database
    func getUsers() {
        userRepository.fetchUsers() { (fetchedUsers) -> Void in // Awaits until completion of fetchUsers()
            self.users = fetchedUsers
            
            // Define RBAC disallowed views for each role
            let staffDisallowed = ["ManagementView", "MenuView", "InventoryView", "StaffView", "AnalyticsView"]
            let managerDisallowed = ["StaffView", "AnalyticsView"]
            
            // Assign disallowed views acording to role
            switch self.users.first(where: { $0.id!.lowercased() == Auth.auth().currentUser!.email! } )!.role { // Requires lowercased() to avoid capitalisation mismatch
                case "staff": self.disallowedViews = staffDisallowed
                case "manager": self.disallowedViews = managerDisallowed
                case "owner": self.disallowedViews = []
                default: self.disallowedViews = staffDisallowed // Default to the lowest privileges
            }
        }
    }
    
    // Adds a new user to the database, by first validating the input
    func addUser() {
        validateInput()
        
        if error == "" {
            // Create new UserModel
            let newUser = UserModel(id: emailInput, firstName: firstNameInput, lastName: lastNameInput, role: roleInput, wage: Decimal(Double(wageInput)!), phone: phoneInput, comment: commentInput)
            
            // Add to database
            _ = userRepository.addUser(user: newUser) // Store in underscore operator as result of function is not needed
        }
    }
    
    // Edits an existing user
    func editUser() {
        // Check if user exists
        guard let originalUser = users.first(where: { $0.id == oldEmailInput }) else {
            print("User doesn't exist")
            return
        }
        
        validateInput()
        
        // Check if another user already has the email
        if emailInput != oldEmailInput && users.firstIndex(where: { $0.id == emailInput }) != nil {
            error = "Email is already registered"
        }
        
        if error == "" {
            // Check if an input is empty, retain the original value if it is, and use the new value if it isn't
            let editedFirstName = firstNameInput == "" ? originalUser.firstName : firstNameInput
            let editedLastName = lastNameInput == "" ? originalUser.lastName : lastNameInput
            let editedRole = roleInput == "" ? originalUser.role : roleInput
            let editedWage = wageInput == "0.00" ? originalUser.wage : Decimal(Double(wageInput)!)
            let editedPhone = phoneInput == "" ? originalUser.phone : phoneInput
            let editedComment = commentInput == "" ? originalUser.comment : commentInput

            // Create a new UserModel with updated data
            let editedUser = UserModel(id: emailInput, firstName: editedFirstName, lastName: editedLastName, role: editedRole, wage: editedWage, phone: editedPhone, comment: editedComment)
            
            _ = userRepository.addUser(user: editedUser) // Store in underscore operator as result of function is not needed
            
            // If emil address is being changed, delete original user
            if emailInput != originalUser.id! {
                userRepository.removeUser(email: oldEmailInput)
            }
        }
    }
    
    // Removes an existing user
    func removeUser() {
        // TODO: delete from FirebaseAuth (owner)
        userRepository.removeUser(email: emailInput)
    }
    
    // Determine if user is allowed to access a view based on their blacklist
    func isUserAllowedInView(view: String) -> Bool {
        return userRepository.staffRBAC(email: Auth.auth().currentUser!.email!, view: view)
    }
}
