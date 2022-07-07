//
//  TableViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation
import SwiftUI
import grpc

final class TableViewModel: ObservableObject {
    @Published var tables = [TableModel]()
    @Published var tableRepository = TableRepository()
    
    @Published var error: String = ""
    
    @Published var tableNumberInput: String = ""
    @Published var seatsInput: Int = 0
    @Published var statusInput: String = ""
    @Published var newTableNumberInput: String = ""
    
    
    func getTables() {
        tableRepository.fetchTables() { (fetchedTables) -> Void in
            self.tables = fetchedTables.sorted { (lhs: TableModel, rhs: TableModel) -> Bool in
                return Int(lhs.id!)! < Int(rhs.id!)!
            }
        }
    }

    func addTable() {
        if tableNumberInput.hasPrefix("0") || tableNumberInput == "" {
            error = "Invalid table number"
        } else if tables.firstIndex(where: { $0.id == tableNumberInput }) != nil {
            error = "Table already exists"
        } else {
            let newTable = TableModel(id: tableNumberInput, seats: seatsInput)
            tableRepository.addTable(table: newTable)
            error = ""
        }
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
    func editTableNumber() {
        if newTableNumberInput.hasPrefix("0") || newTableNumberInput == "" {
            error = "Invalid table number"
        } else if tables.firstIndex(where: { $0.id == newTableNumberInput }) != nil {
            error = "Table already exists"
        } else {
            let existingTable = tables.first(where: { $0.id == tableNumberInput } )

            let existingSeats = existingTable!.seats
            let existingStatus = existingTable!.status

            let editedTable = TableModel(id: newTableNumberInput, seats: existingSeats, status: existingStatus)
            tableRepository.addTable(table: editedTable)
            
            tableRepository.removeTable(tableNumber: tableNumberInput)
            error = ""
        }
    }
    
    func removeTable() {
        tableRepository.removeTable(tableNumber: tableNumberInput)
    }
    
    
    // IndividualTableView:
    func tableColor(status: String) -> Color {
        switch status {
            case "free": return Color.green
            case "yetToOrder": return Color.orange
            case "ordered": return Color.orange
            case "eating": return Color.orange
            case "cleaning": return Color.cyan
            case "reserved": return Color.red
            case "unavailable": return Color.gray
            default: return Color.gray
        }
    }
}
