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
            
            Text("Table \(table.id!)")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct IndividualTableView_Previews: PreviewProvider {
    static var sampleTable = TableModel(id: "12", seats: 8, status: "free")
    
    static var previews: some View {
        IndividualTableView(table: sampleTable)
            .frame(width: 200, height: 200)
    }
}
