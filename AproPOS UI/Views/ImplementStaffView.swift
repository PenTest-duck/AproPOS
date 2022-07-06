//
//  ImplementStaffView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 6/7/22.
//

import SwiftUI

struct ImplementStaffView: View {
    
    @StateObject private var staffVM = StaffViewModel()
    
    var body: some View {
        VStack {
            TextField(" Email", text: $staffVM.userEmailInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            TextField(" First name", text: $staffVM.userFirstNameInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            TextField(" Last name", text: $staffVM.userLastNameInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            Button(action: {
                staffVM.editUser()
            }) {
                Text("Edit user")
            }
            
            Button(action: {
                staffVM.getUsers()
            }) {
                Text("Get users")
            }
        }
        .onAppear {
            staffVM.getUsers()
        }
    }
}

struct ImplementStaffView_Previews: PreviewProvider {
    static var previews: some View {
        ImplementStaffView().previewInterfaceOrientation(.landscapeLeft)
    }
}
