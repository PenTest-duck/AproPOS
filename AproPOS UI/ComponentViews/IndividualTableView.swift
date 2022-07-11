//
//  IndividualTableView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 6/7/22.
//

import SwiftUI

struct IndividualTableView: View {
    
    @StateObject private var tableVM = TableViewModel()
    
    let table: TableModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(tableVM.tableColor(status: table.status))
            
            VStack {
                ZStack {
                    HStack {
                        Text("Table \(table.id!)")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("\(table.seats)")
                            .font(.title)
                            .foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255))
                    }.padding(.trailing, 25)
                }
            }
        }
    }
}

struct IndividualTableView_Previews: PreviewProvider {
    static var sampleTable = TableModel(id: "12", seats: 8, status: "free")
    
    static var previews: some View {
        IndividualTableView(table: sampleTable)
            .frame(width: 600, height: 40)
    }
}
