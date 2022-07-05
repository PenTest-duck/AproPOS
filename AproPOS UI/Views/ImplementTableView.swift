//
//  ImplementTableView.swift
//  AproPOS UI
//
//  Created by Kushaagra Kesarwani on 5/7/2022.
//

import SwiftUI

struct ImplementTableView: View {
    @StateObject private var tableVM = TableViewModel()
    
    var body: some View {
        VStack {
            
            TextField(" Table Number", text: $tableVM.tableNumberInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 300)
                .font(.system(size: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            
            
            Button(action: {
                tableVM.seatsInput = 4
                tableVM.addTable()
            }) {
                Text("Add Table")
            }
            
            Button(action: {
                tableVM.getTables()
            }) {
                Text("Get Tables")
            }
            
            Button(action: {
                tableVM.removeTable()
            }) {
                Text("Remove Table")
            }
        }
    }
    
}
struct ImplementTableView_Previews: PreviewProvider {
    static var previews: some View {
        ImplementTableView().previewInterfaceOrientation(.landscapeLeft)
    }
}

