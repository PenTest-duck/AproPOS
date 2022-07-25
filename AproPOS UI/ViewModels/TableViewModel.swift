//
//  TableViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation
import SwiftUI // only for Color

final class TableViewModel: ObservableObject {
    // Table storage and repository
    @Published var tables = [TableModel]()
    @Published var tableRepository = TableRepository()
    
    // Error field
    @Published var error: String = ""
    
    // Input fields
    @Published var tableNumberInput: String = ""
    @Published var seatsInput: Int = 0
    @Published var statusInput: String = ""
    @Published var newTableNumberInput: String = ""
    
    // Obtains updated table data, sorts them numerically, then stores them in variable tables
    func getTables() {
        tableRepository.fetchTables() { (fetchedTables) -> Void in // Closure waits for asynchronous fetching of table data
            self.tables = fetchedTables.sorted { (lhs: TableModel, rhs: TableModel) -> Bool in
                // Sort by ascending order
                return Int(lhs.id!)! < Int(rhs.id!)!
            }
        }
    }

    // Adds a new table to the database, by first validating the input
    func addTable() {
        if tableNumberInput.hasPrefix("0") || tableNumberInput == "" { // Check if number begins with 0 or is empty
            error = "Invalid table number"
        } else if tables.firstIndex(where: { $0.id == tableNumberInput }) != nil { // Check if table already exists
            error = "Table already exists"
        } else {
            // Create a new table and add to Firestore
            let newTable = TableModel(id: tableNumberInput, seats: seatsInput)
            tableRepository.addTable(table: newTable)
            error = ""
        }
    }

    // Edits an existing table
    func editTable() {
        // Check if original table exists
        guard let originalTable = tables.first(where: { $0.id == tableNumberInput }) else {
            print("Table doesn't exist")
            return
        }
        
        // Check if an input is empty, retain the original value if it is, and use the new value if it isn't
        let editedSeats = seatsInput == 0 ? originalTable.seats : seatsInput
        let editedStatus = statusInput == "" ? originalTable.status : statusInput
        let editedTable = TableModel(id: tableNumberInput, seats: editedSeats, status: editedStatus)
        
        tableRepository.addTable(table: editedTable)
    }
    
    // Edits the table number of an existing table
    func editTableNumber() {
        if newTableNumberInput.hasPrefix("0") || newTableNumberInput == "" { // Check if number begins with 0 or is empty
            error = "Invalid table number"
        } else if tables.firstIndex(where: { $0.id == newTableNumberInput }) != nil { // Check if table already exists
            error = "Table already exists"
        } else {
            // Retrieve the existing table
            let existingTable = tables.first(where: { $0.id == tableNumberInput } )
            
            // Save all non-ID data of existing table into variables
            let existingSeats = existingTable!.seats
            let existingStatus = existingTable!.status

            // Create a new table with the saved data, and new table number as the ID
            let editedTable = TableModel(id: newTableNumberInput, seats: existingSeats, status: existingStatus)
            tableRepository.addTable(table: editedTable)
            
            // Remove the original table
            tableRepository.removeTable(tableNumber: tableNumberInput)
            error = ""
        }
    }
    
    // Removes an existing table
    func removeTable() {
        tableRepository.removeTable(tableNumber: tableNumberInput)
    }
    
    
    // Provides colours for IndividualTableView based on table status
    func tableColor(status: String) -> Color {
        switch status {
            case "free": return Color.green
            case "yetToOrder": return Color.init(red: 160/255, green: 236/255, blue: 208/255)
            case "ordered": return Color.orange
            case "served": return Color.init(red: 8/255, green: 61/255, blue: 119/255)
            case "cleaning": return Color.cyan
            case "reserved": return Color.red
            case "unavailable": return Color.gray
            default: return Color.gray
        }
    }
}
