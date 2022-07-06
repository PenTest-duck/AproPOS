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
    
// Code following has been created by Kushaagra Kesarwani on 5/7/22
    @Published var tableNumberInput: String = ""
    @Published var seatsInput: Int = 0
    @Published var statusInput: String = ""
    @Published var newTableNumberInput: String = ""
    
    
    func getTables() {
        tableRepository.fetchTables() { (fetchedTables) -> Void in
            self.tables = fetchedTables
        }
    }

    func addTable() {
        let newTable = TableModel(id: tableNumberInput, seats: seatsInput)
        tableRepository.addTable(table: newTable)
    }
// Code following has been create by Chris Yoo on 5/7/22
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
    
    func editTableNumber() {
            let existingTable = tables.first(where: { $0.id == tableNumberInput } )

            let existingSeats = existingTable!.seats
            let existingStatus = existingTable!.status

            let editedTable = TableModel(id: newTableNumberInput, seats: existingSeats, status: existingStatus)
            tableRepository.addTable(table: editedTable)

            tableRepository.removeTable(tableNumber: tableNumberInput)
    }
    
    func removeTable() {
        tableRepository.removeTable(tableNumber: tableNumberInput)
    }
}
