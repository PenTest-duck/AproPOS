//
//  StaffViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 5/7/22.
//

import Foundation
import FirebaseAuth

final class StaffViewModel: ObservableObject {
    @Published var users = [UserModel]()
    @Published var userRepository = UserRepository()
    
    @Published var error = ""
    @Published var disallowedViews: [String] = []
    
    @Published var emailInput: String = ""
    @Published var firstNameInput: String = ""
    @Published var lastNameInput: String = ""
    @Published var roleInput: String = ""
    @Published var wageInput: String = "0.00" // Decimal = 0.00
    @Published var phoneInput: String = ""
    @Published var commentInput: String = ""
    
    @Published var oldEmailInput: String = ""
    
    func validateInput(operation: String) {
        if emailInput == "" {
            error = "Please enter an email address"
        } else if firstNameInput == "" || lastNameInput == "" {
            error = "Please enter the first and lasttC name"
        } else if !AuthViewModel().isValidEmail(emailInput) {
            error = "Invalid email address"
        } else if wageInput.hasPrefix(".") || (wageInput.filter { $0 == "." }).count >= 2 {
            error = "Invalid wage"
        } else if wageInput[(wageInput.firstIndex(of: ".") ?? wageInput.index(wageInput.endIndex, offsetBy: -1))...].count > 3 {
            error = "Currency allows max. 2 decimal places"
        } else if Double(wageInput)! == 0 {
            error = "Wage cannot be zero"
        } else {
            error = ""
        }
    }
    
    func getUsers() {
        userRepository.fetchUsers() { (fetchedUsers) -> Void in
            self.users = fetchedUsers
            
            let staffDisallowed = ["ManagementView", "MenuView", "InventoryView", "StaffView", "AnalyticsView"]
            let managerDisallowed = ["StaffView", "AnalyticsView"]
            
            switch self.users.first(where: { $0.id == Auth.auth().currentUser!.email! } )!.role {
                case "staff": self.disallowedViews = staffDisallowed
                case "manager": self.disallowedViews = managerDisallowed
                case "owner": self.disallowedViews = []
                default: self.disallowedViews = staffDisallowed
            }
        }
    }
    
    func addUser() {
        validateInput(operation: "add")
        if error == "" {
            let newUser = UserModel(id: emailInput, firstName: firstNameInput, lastName: lastNameInput, role: roleInput, wage: Decimal(Double(wageInput)!), phone: phoneInput, comment: commentInput)
            _ = userRepository.addUser(user: newUser)
        }
    }
    
    func editUser() {
        guard let originalUser = users.first(where: { $0.id == oldEmailInput }) else {
            print("User doesn't exist")
            return
        }
        
        validateInput(operation: "edit")
        if emailInput != oldEmailInput && users.firstIndex(where: { $0.id == emailInput }) != nil {
            error = "Email is already registered"
        }
        
        if error == "" {
            let editedFirstName = firstNameInput == "" ? originalUser.firstName : firstNameInput
            let editedLastName = lastNameInput == "" ? originalUser.lastName : lastNameInput
            let editedRole = roleInput == "" ? originalUser.role : roleInput
            let editedWage = wageInput == "0.00" ? originalUser.wage : Decimal(Double(wageInput)!)
            let editedPhone = phoneInput == "" ? originalUser.phone : phoneInput
            let editedComment = commentInput == "" ? originalUser.comment : commentInput

            let editedUser = UserModel(id: emailInput, firstName: editedFirstName, lastName: editedLastName, role: editedRole, wage: editedWage, phone: editedPhone, comment: editedComment)
            _ = userRepository.addUser(user: editedUser)
            
            if emailInput != originalUser.id! { // if changing email address
                userRepository.removeUser(email: oldEmailInput)
            }
        }
    }
    
    func removeUser() {
        // TODO: delete from FirebaseAuth (owner)
        userRepository.removeUser(email: emailInput)
    }
    
    // TODO: Staff RBAC
    func isUserAllowedInView(view: String) -> Bool {
        return userRepository.staffRBAC(email: Auth.auth().currentUser!.email!, view: view)
    }
}
