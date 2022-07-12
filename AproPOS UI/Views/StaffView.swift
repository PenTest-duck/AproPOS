//
//  StaffView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 11/7/22.
//

import SwiftUI
import Combine
//import PhoneNumberKit

struct StaffView: View {
    @StateObject private var staffVM = StaffViewModel()
    
    @State private var selectedStaff: UserModel? = nil
    @State private var addingStaff: Bool = false
    @State private var confirmingDelete: Bool = false
    
    var body: some View {
        if !confirmingDelete {
            HStack (spacing: 0) {
                VStack {
                    VStack {
                        ZStack {
                            HStack {
                                Text("Staff")
                                    .font(.system(size: 55))
                                    .fontWeight(.bold)
                            }
                                
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    addingStaff = true
                                    staffVM.error = ""
                                    staffVM.emailInput = ""
                                    staffVM.firstNameInput = ""
                                    staffVM.lastNameInput = ""
                                    staffVM.roleInput = ""
                                    staffVM.wageInput = "0.00"
                                    staffVM.phoneInput = ""
                                    staffVM.commentInput = ""
                                }) {
                                    Image(systemName: "plus.square.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.green)
                                }
                                .padding(.trailing, 10)
                            }
                            Spacer()
                        }
                    }
                    
                    ZStack {
                        if staffVM.users == [] {
                            VStack(spacing: 10) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 50))
                                Text("No users")
                                    .font(.system(size: 50))
                                    .fontWeight(.semibold)
                                Text("Create a user by pressing the add icon.")
                                    .font(.system(size: 20))
                            }.padding(.bottom, 90)
                        }
                        
                        List {
                            ForEach(staffVM.users) { user in
                                Button(action: {
                                    addingStaff = false
                                    staffVM.error = ""
                                    selectedStaff = user
                                    staffVM.emailInput = selectedStaff!.id!
                                    staffVM.firstNameInput = selectedStaff!.firstName
                                    staffVM.lastNameInput = selectedStaff!.lastName
                                    staffVM.roleInput = selectedStaff!.role
                                    staffVM.wageInput = String(describing: selectedStaff!.wage)
                                    staffVM.phoneInput = selectedStaff!.phone
                                    staffVM.commentInput = selectedStaff!.comment
                                }) {
                                    IndividualUserView(user: user)
                                }.listRowBackground(Color(red: 242/255, green: 242/255, blue: 248/255))
                            }
                        }.listStyle(PlainListStyle())
                    }
                }
                
                Spacer()
                
                Divider()
                    .frame(width: 10)
                    .background(.red)
                
                
                ZStack {
                    VStack {
                        if addingStaff {
                            Text("New Staff")
                                .font(Font.custom("DIN Bold", size: 60))
                            
                            HStack {
                                Text("Email")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $staffVM.emailInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 300, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("First Name")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $staffVM.firstNameInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 230, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Last Name")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $staffVM.lastNameInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 230, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Role")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Button(action: {
                                    staffVM.roleInput = "staff"
                                }) {
                                    Text("Staff")
                                        .foregroundColor(staffVM.roleInput == "staff" ? Color.red : Color.blue)
                                }
                                
                                Text("|")
                                
                                Button(action: {
                                    staffVM.roleInput = "manager"
                                }) {
                                    Text("Manager")
                                        .foregroundColor(staffVM.roleInput == "manager" ? Color.red : Color.blue)
                                }
                                
                                Text("|")
                                
                                Button(action: {
                                    staffVM.roleInput = "owner"
                                }) {
                                    Text("Owner")
                                        .foregroundColor(staffVM.roleInput == "owner" ? Color.red : Color.blue)
                                }
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Wage")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Text("$")
                                
                                TextField("", text: $staffVM.wageInput)
                                    .background(.white)
                                    .frame(width: 125, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                                    .onReceive(Just(staffVM.wageInput)) { newValue in
                                        let filtered = newValue.filter { ".0123456789".contains($0) }
                                        if filtered != newValue {
                                            staffVM.wageInput = filtered
                                        }
                                    }
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Phone")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $staffVM.phoneInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 300, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            VStack {
                                Text("Comment")
                                    .fontWeight(.bold)
                                
                                TextEditor(text: $staffVM.commentInput)
                                    .foregroundColor(.black)
                                    .font(.system(size: 25))
                                    .background(.white)
                                    .frame(height: 200)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.leading)
                                    
                            }.padding(.horizontal, 20)
                                .padding(.bottom, 10)
                            
                            Spacer()
                            
                            Group {
                                Button(action: {
                                    staffVM.addUser()
                                    if staffVM.error == "" {
                                        self.selectedStaff = nil
                                        addingStaff = false
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .cornerRadius(30)
                                            .foregroundColor(Color.blue)
                                            .frame(width: 380, height: 100)
                                            .padding(.bottom, 10)
                                        
                                        Text("Add Staff")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .padding(.bottom, 10)
                                            .font(.system(size: 35))
                                    }
                                }
                                
                                Text("\(staffVM.error)")
                                    .foregroundColor(.red)
                                    .font(.system(size: 22))
                                    .frame(maxWidth: 380)
                            }
                        } else if let selectedStaff = selectedStaff {
                            VStack {
                                Text("\(selectedStaff.firstName)")
                                    .font(Font.custom("DIN Bold", size: 50))
                                
                                Text("\(selectedStaff.lastName)")
                                    .font(Font.custom("DIN Bold", size: 50))
                            }
                            
                            HStack {
                                Text("Email")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $staffVM.emailInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 300, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("First Name")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $staffVM.firstNameInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 230, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Last Name")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $staffVM.lastNameInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 230, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Role")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Button(action: {
                                    staffVM.roleInput = "staff"
                                }) {
                                    Text("Staff")
                                        .foregroundColor(staffVM.roleInput == "staff" ? Color.red : Color.blue)
                                }
                                
                                Text("|")
                                
                                Button(action: {
                                    staffVM.roleInput = "manager"
                                }) {
                                    Text("Manager")
                                        .foregroundColor(staffVM.roleInput == "manager" ? Color.red : Color.blue)
                                }
                                
                                Text("|")
                                
                                Button(action: {
                                    staffVM.roleInput = "owner"
                                }) {
                                    Text("Owner")
                                        .foregroundColor(staffVM.roleInput == "owner" ? Color.red : Color.blue)
                                }
                                    
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Wage")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Text("$")
                                
                                TextField("", text: $staffVM.wageInput)
                                    .background(.white)
                                    .frame(width: 125, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                                    .onReceive(Just(staffVM.wageInput)) { newValue in
                                        let filtered = newValue.filter { ".0123456789".contains($0) }
                                        if filtered != newValue {
                                            staffVM.wageInput = filtered
                                        }
                                    }
                            }.padding(.horizontal, 20)
                            
                            HStack {
                                Text("Phone")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $staffVM.phoneInput)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(.white)
                                    .frame(width: 300, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    
                            }.padding(.horizontal, 20)
                            
                            VStack {
                                Text("Comment")
                                    .fontWeight(.bold)
                                
                                TextEditor(text: $staffVM.commentInput)
                                    .foregroundColor(.black)
                                    .font(.system(size: 25))
                                    .background(.white)
                                    .frame(height: 200)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.leading)
                                    
                            }.padding(.horizontal, 20)
                                .padding(.bottom, 10)
                            
                            Spacer()
                            
                            Group {
                                HStack {
                                    Spacer()
                                    
                                    Text("Remove User")
                                        .fontWeight(.bold)
                                    
                                    Button(action: {
                                        staffVM.emailInput = selectedStaff.id!
                                        confirmingDelete = true
                                    }) {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 40))
                                    }
                                }.padding(.horizontal, 20)

                                Button(action: {
                                    staffVM.oldEmailInput = selectedStaff.id!
                                    staffVM.editUser()
                                    if staffVM.error == "" {
                                        self.selectedStaff = nil
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .cornerRadius(30)
                                            .foregroundColor(Color.blue)
                                            .frame(width: 380, height: 85)
                                            .padding(.bottom, 10)
                                        
                                        Text("Save changes")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .padding(.bottom, 10)
                                            .font(.system(size: 35))
                                    }
                                }
                                
                                Text("\(staffVM.error)")
                                    .foregroundColor(.red)
                                    .font(.system(size: 22))
                                    .frame(maxWidth: 380)
                            }
                        } else {
                            Text("Select a user")
                                .font(Font.custom("DIN Bold", size: 60))
                        }
                        
                    }.frame(maxWidth: 450, maxHeight: 700)
                    .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                    .font(.system(size: 30))
                }
            }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .navigationBarHidden(true)
                .onAppear {
                    staffVM.getUsers()
                }
            
        } else {
            ZStack {
                Color(red: 220/255, green: 220/255, blue: 220/255).ignoresSafeArea()
                RoundedRectangle(cornerRadius:20)
                    .frame(width: 400, height: 220)
                    .foregroundColor(.white)
                
                VStack {
                    if confirmingDelete {
                        Text("**Delete Staff \(staffVM.firstNameInput) \(staffVM.lastNameInput)?**")
                            .font(.system(size: 40))
                        Spacer()
                        HStack {
                            Button(action: {
                                confirmingDelete = false
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 40))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                staffVM.removeUser()
                                self.selectedStaff = nil
                                confirmingDelete = false
                            }) {
                                Text("Delete")
                                    .foregroundColor(.red)
                                    .font(.system(size: 40))
                            }
                        }.padding(.horizontal, 50)
                    }
                }.frame(width: 400, height: 160)
            }
        }
    }
}

struct StaffView_Previews: PreviewProvider {
    static var previews: some View {
        StaffView().previewInterfaceOrientation(.landscapeLeft)
    }
}
