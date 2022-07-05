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
    @Published var statusInput: String = ""
    
    func getTables() {
        tableRepository.fetchTables() { (fetchedTables) -> Void in
            self.tables = fetchedTables
        }
    }

    func addTable() {
        let newTable = TableModel(id: tableNumberInput, seats: seatsInput)
        tableRepository.addTable(table: newTable)
    }
    
    func editTable() {
        guard let originalTable = tables.first(where: { $0.id == tableNumberInput }) else {
            print("Table doesn't exist")
            return
        }
        
        let editedSeats = seatsInput == 0 ? originalTable.seats : seatsInput
        let editedStatus = statusInput == "" ? originalTable.status : statusInput
        let editedTable = TableModel(id: tableNumberInput, seats: editedSeats, status: editedStatus)
        
        tableRepository.addTable(table: editedTable)
    }
    
    // TODO: editTableNumber()
    
    func removeTable() {
        tableRepository.removeTable(tableNumber: tableNumberInput)
    }
}
