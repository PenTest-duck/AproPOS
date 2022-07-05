//
//  StaffViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 5/7/22.
//

import Foundation

final class StaffViewModel: ObservableObject {
    @Published var users = [UserModel]()
    @Published var userRepository = UserRepository()
    
    @Published var userEmailInput: String = ""
    @Published var userFirstNameInput: String = ""
    @Published var userLastNameInput: String = ""
    @Published var userRoleInput: String = ""
    @Published var userWageInput: Decimal = 0.00
    @Published var userPhoneInput: String = ""
    @Published var userCommentInput: String = ""
    
    func getUsers() {
        userRepository.fetchUsers() { (fetchedUsers) -> Void in
            self.users = fetchedUsers
        }
    }
    
    /*func editUser() {
        guard let originalUser = users.first(where: { $0.id == userEmailInput }) else {
            print("User doesn't exist")
            return
        }
        
        let editedFirstName = userFirstNameInput == "" ? originalUser.firstName : userFirstNameInput
        let editedLastName = userLastNameInput == "" ? originalUser.lastName : userLastNameInput
        let editedRole = userRoleInput == "" ? originalUser.role : userRoleInput
        let editedWage = userWageInput == 0.00 ? originalUser.wage : userWageInput
        let editedPhone = userPhoneInput == "" ? originalUser.phone : userPhoneInput
        let editedComment = userCommentInput == "" ? originalUser.comment : userCommentInput
        
        let editedUser = UserModel(id: userEmailInput, firstName: editedFirstName, lastName: editedLastName, role: editedRole, wage: editedWage, phone: editedPhone, comment: editedComment)
        
        _ = userRepository.addUser(user: editedUser)
    }*/
    
    // TODO: Staff RBAC
    
    func removeUser(email: String) {
        // TODO: delete from FirebaseAuth
        userRepository.removeUser(email: email)
    }
}
