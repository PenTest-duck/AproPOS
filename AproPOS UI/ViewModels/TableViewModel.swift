//
//  TableViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation

final class TableViewModel: ObservableObject {
    @Published var tables = [TableModel]()
    @Published var tableRepository = TableRepository()
    @Published var tableNumberInput: String = ""
    @Published var seatsInput: Int = 0
    @Published var statusInput: String = "free"
    
    func getTables() {
        tables = tableRepository.fetchTables()
    }
     //to add crud functionality
    func addTable() {
        let newTable = TableModel(id: tableNumberInput, seats: seatsInput)
        _ = tableRepository.addTable(table: newTable)
    }
    
    func removeTable() {
        tableRepository.removeTable(tableNumber: tableNumberInput)
    }
}
