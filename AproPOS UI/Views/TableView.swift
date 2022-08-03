//
//  TableView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 6/7/22.
//

import SwiftUI
import Combine

struct TableView: View {
    @StateObject private var tableVM = TableViewModel()
    
    @State private var selectedTable: TableModel? = nil
    @State private var addingTable: Bool = false
    @State private var confirmingDelete: Bool = false
    @State private var editingTableNumber: Bool = false
    
    static var uniqueKey: String {
        UUID().uuidString
    }

    // Table status options
    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "free"),
        DropdownOption(key: uniqueKey, value: "yetToOrder"),
        DropdownOption(key: uniqueKey, value: "ordered"),
        DropdownOption(key: uniqueKey, value: "served"),
        DropdownOption(key: uniqueKey, value: "cleaning"),
        DropdownOption(key: uniqueKey, value: "reserved"),
        DropdownOption(key: uniqueKey, value: "unavailable")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                if !confirmingDelete && !editingTableNumber { // Normal case when not deleting or editing table number
                    HStack (spacing: 0) {
                        VStack {
                            // Centered title + add table button
                            VStack {
                                ZStack {
                                    HStack {
                                        Text("Tables")
                                            .font(.system(size: 60))
                                            .fontWeight(.bold)
                                    }
                                        
                                    HStack {
                                        Spacer()
                                        
                                        // Add table button
                                        Button(action: {
                                            // Clear values
                                            addingTable = true
                                            tableVM.error = ""
                                            tableVM.tableNumberInput = ""
                                            tableVM.seatsInput = 1
                                            tableVM.statusInput = ""
                                        }) {
                                            Image(systemName: "plus.square.fill")
                                                .font(.system(size: 60))
                                                .foregroundColor(Color.green)
                                        }
                                        .padding(.trailing, 10)
                                    }
                                    Spacer()
                                }
                            }
                            
                            ZStack {
                                if tableVM.tables == [] { // View for when there are no tables
                                    VStack(spacing: 10) {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 50))
                                        Text("No tables")
                                            .font(.system(size: 50))
                                            .fontWeight(.semibold)
                                        Text("Add your first table by pressing the add icon.")
                                            .font(.system(size: 20))
                                    }.padding(.bottom, 90)
                                }
                                
                                List {
                                    // List of all tables
                                    ForEach(tableVM.tables) { table in
                                        Button(action: {
                                            // Pre-fill values for editing when pressed
                                            addingTable = false
                                            tableVM.error = ""
                                            selectedTable = table
                                            tableVM.seatsInput = selectedTable!.seats
                                            tableVM.statusInput = selectedTable!.status
                                        }) {
                                            IndividualTableView(table: table)
                                        }.listRowBackground(Color(red: 242/255, green: 242/255, blue: 248/255))
                                    }
                                }.listStyle(PlainListStyle())
                            }
                        }
                        
                        Spacer()
                        
                        Divider()
                            .frame(width: 10)
                            .background(Color(red: 202/255, green: 85/255, blue: 220/255))
                        
                        // Input fields
                        ZStack {
                            VStack {
                                if addingTable { // If adding a table
                                    Text("New Table")
                                        .font(Font.custom("DIN Bold", size: 60))
                                    
                                    // Table number input
                                    HStack {
                                        Text("Table Number")
                                            .fontWeight(.bold)
                                        
                                        Spacer()
                                        
                                        TextField("", text: $tableVM.tableNumberInput)
                                            .background(.white)
                                            .frame(width: 100, height: 40)
                                            .cornerRadius(25)
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.numberPad)
                                            .onReceive(Just(tableVM.tableNumberInput)) { newValue in // Filter only numbers
                                                let filtered = newValue.filter { "0123456789".contains($0) }
                                                if filtered != newValue {
                                                    tableVM.tableNumberInput = filtered
                                                }
                                            }
                                    }.padding(.horizontal, 20)
                                    
                                    // Seats input
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Seats")
                                                .fontWeight(.bold)
                                            
                                            Spacer()
                                            
                                            // Stepper from 1 to 20
                                            Stepper("\(tableVM.seatsInput)", value: $tableVM.seatsInput, in: 1...20)
                                        }.padding(.horizontal, 20)
                                    }
                                    
                                    Spacer()
                                    
                                    // Add table button
                                    Button(action: {
                                        // Perform the add table function
                                        tableVM.addTable()
                                        if tableVM.error == "" { // If success
                                            // Reset values
                                            self.selectedTable = nil
                                            addingTable = false
                                        }
                                    }) {
                                        ZStack {
                                            Rectangle()
                                                .cornerRadius(30)
                                                .foregroundColor(Color(red: 8/255, green: 61/255, blue: 119/255))
                                                .frame(width: 380, height: 100)
                                                .padding(.bottom, 10)
                                            
                                            Text("Add Table")
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                                .padding(.bottom, 10)
                                                .font(.system(size: 35))
                                        }
                                    }
                                    
                                    // Error display
                                    Text("\(tableVM.error)")
                                        .foregroundColor(.red)
                                    
                                } else if let selectedTable = selectedTable { // If an existing table has been pressed
                                    // Adjust input field title
                                    Text("Table \(selectedTable.id!)")
                                        .font(Font.custom("DIN Bold", size: 60))
                                    
                                    // Edit table number button
                                    Button(action: {
                                        editingTableNumber = true
                                    }) {
                                        HStack {
                                            Image(systemName: "pencil.tip.crop.circle")
                                            Text("Edit Table Number")
                                        }.font(.system(size: 20))
                                    }.padding(.bottom, 30)
                                    
                                    // Seats input
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Seats")
                                                .fontWeight(.bold)
                                            
                                            Spacer()
                                            
                                            Stepper("\(tableVM.seatsInput)", value: $tableVM.seatsInput, in: 1...20)
                                        }.padding(.horizontal, 20)
                                    }
                                    
                                    // Status input
                                    HStack {
                                        Text("Status")
                                            .fontWeight(.bold)
                                        
                                        // Dropdown select from available statuses
                                        DropdownSelector(
                                            placeholder: "\(tableVM.statusInput)",
                                            options: TableView.options,
                                            onOptionSelected: { option in
                                                tableVM.statusInput = option.value
                                            }
                                        )
                                    }.padding(.horizontal, 20)
                                    
                                    Spacer()
                                    
                                    // Save changes button
                                    Button(action: {
                                        // Perform edit table function
                                        tableVM.tableNumberInput = selectedTable.id!
                                        tableVM.editTable()
                                        
                                        // Reset selected table value
                                        self.selectedTable = nil
                                    }) {
                                        ZStack {
                                            Rectangle()
                                                .cornerRadius(30)
                                                .foregroundColor(Color(red: 8/255, green: 61/255, blue: 119/255))
                                                .frame(width: 380, height: 85)
                                                .padding(.bottom, 10)
                                            
                                            Text("Save changes")
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                                .padding(.bottom, 10)
                                                .font(.system(size: 35))
                                        }
                                    }
                                    
                                    // Remove button
                                    HStack {
                                        Spacer()
                                        
                                        Button(action: {
                                            tableVM.tableNumberInput = selectedTable.id!
                                            confirmingDelete = true
                                        }) {
                                            Image(systemName: "trash.fill")
                                                .foregroundColor(.red)
                                                .font(.system(size: 40))
                                                .padding(.trailing, 170)
                                        }
                                    }.padding(.horizontal, 20)
                                    
                                } else { // If neither the add button nor an existing table has been pressed
                                    Text("Select a table")
                                        .font(Font.custom("DIN Bold", size: 60))
                                }
                                
                            }.frame(maxWidth: 450, maxHeight: 550)
                                .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                                .font(.system(size: 30))
                        }
                    }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .onAppear {
                            // Start synchronising data
                            tableVM.getTables()
                        }
                    
                } else { // If requiring a prompt either for removing table or changing table number
                    ZStack {
                        // Input prompt background
                        Color(red: 220/255, green: 220/255, blue: 220/255).ignoresSafeArea()
                        RoundedRectangle(cornerRadius:20)
                            .frame(width: 400, height: 220)
                            .foregroundColor(.white)
                        
                        VStack {
                            if confirmingDelete { // If deleting a table
                                // Confirm deleting table
                                Text("**Delete Table \(tableVM.tableNumberInput)?**")
                                    .font(.system(size: 40))
                                
                                Spacer()
                                
                                HStack {
                                    // Cancel button
                                    Button(action: {
                                        confirmingDelete = false // Returns to TableView
                                    }) {
                                        Text("Cancel")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 40))
                                    }
                                    
                                    Spacer()
                                    
                                    // Remove button
                                    Button(action: {
                                        tableVM.removeTable()
                                        self.selectedTable = nil
                                        confirmingDelete = false // Returns to TableView
                                    }) {
                                        Text("Delete")
                                            .foregroundColor(.red)
                                            .font(.system(size: 40))
                                    }
                                }.padding(.horizontal, 50)

                            } else if editingTableNumber { // If editing the table number
                                Text("**Edit Table Number**")
                                    .font(.system(size: 30))
                                
                                // Current table number
                                Text("Table \(self.selectedTable!.id!)")
                                    .font(.system(size: 23))
                                    .foregroundColor(.orange)
                                
                                Spacer()
                                
                                // New table number input
                                HStack {
                                    Text("**New Number**")
                                        .font(.system(size: 20))
                                    
                                    Spacer()
                                    
                                    TextField("", text: $tableVM.newTableNumberInput)
                                        .frame(width: 150, height: 40)
                                        .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.numberPad)
                                        .onReceive(Just(tableVM.newTableNumberInput)) { newValue in // Filters only numbers
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                tableVM.newTableNumberInput = filtered
                                            }
                                        }
                                }.padding(.horizontal, 50)
                                
                                Spacer()
                                
                                HStack {
                                    // Cancel button
                                    Button(action: {
                                        tableVM.error = ""
                                        editingTableNumber = false // Return to TableView
                                    }) {
                                        Text("Cancel")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 20))
                                    }
                                    
                                    Spacer()
                                    
                                    // Save changes button
                                    Button(action: {
                                        // Perform edit table number function
                                        tableVM.tableNumberInput = selectedTable!.id!
                                        tableVM.editTableNumber()
                                        
                                        if tableVM.error == "" { // If success
                                            // Reset variables
                                            self.selectedTable = nil
                                            tableVM.newTableNumberInput = ""
                                            editingTableNumber = false // Return to TableView
                                        }
                                    }) {
                                        Text("Save Changes")
                                            .font(.system(size: 20))
                                    }
                                }.padding(.horizontal, 50)
                          
                                // Error display
                                Text("\(tableVM.error)")
                                    .foregroundColor(.red)
                            }
                        }.frame(width: 400, height: 160)
                    }.padding(.top, 30)
                        .ignoresSafeArea()
                }
                
                if !editingTableNumber && !confirmingDelete {
                    // Help button
                    VStack {
                        HStack {
                            Spacer()
                            Link(destination: URL(string: "https://docs.google.com/document/d/1fmndVOoGDhNku8Z8J-9fgqND61m4VME4OHuz0bK8KRA/edit#bookmark=id.iw3dn7mc99d9")!) {
                                Image(systemName: "questionmark.circle.fill")
                                    .font(.system(size: 50))
                            }
                        }.padding(.trailing, 40)
                        Spacer()
                    }.padding(.top, 12)
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView().previewInterfaceOrientation(.landscapeRight)
    }
}
