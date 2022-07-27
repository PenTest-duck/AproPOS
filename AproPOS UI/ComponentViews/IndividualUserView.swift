//
//  IndividualUserView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 11/7/22.
//

import SwiftUI

struct IndividualUserView: View {
    
    @StateObject private var staffVM = StaffViewModel()
    
    let user: UserModel
    
    func staffColor(role: String) -> Color {
        switch role {
            case "staff": return Color.green
            case "manager": return Color.blue
            case "owner": return Color.purple
            default: return Color.green
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(staffColor(role: user.role))
            
            
            VStack {
                ZStack {
                    HStack {
                        Text("\(user.firstName) \(user.lastName)")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                    }
                }
            }
        }
    }
}

struct IndividualUserView_Previews: PreviewProvider {
    static var sampleUser = UserModel(id: "Yoo_Ch@student.kings.edu.au", firstName: "Chris", lastName: "Yoo", role: "owner", wage: 16.25, phone: "012341234", comment: "Very nice")
    
    static var previews: some View {
        IndividualUserView(user: sampleUser).frame(width: 600, height: 50)
    }
}
