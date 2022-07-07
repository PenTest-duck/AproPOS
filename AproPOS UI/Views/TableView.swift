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
    //@State private var error: String = ""
    
    static var uniqueKey: String {
        UUID().uuidString
    }

    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "free"),
        DropdownOption(key: uniqueKey, value: "yetToOrder"),
        DropdownOption(key: uniqueKey, value: "ordered"),
        DropdownOption(key: uniqueKey, value: "eating"),
        DropdownOption(key: uniqueKey, value: "cleaning"),
        DropdownOption(key: uniqueKey, value: "reserved"),
        DropdownOption(key: uniqueKey, value: "unavailable")
    ]
    
    var body: some View {
        if !confirmingDelete && !editingTableNumber {
            HStack (spacing: 0) {
                VStack {
                    VStack {
                        ZStack {
                            HStack {
                                Text("Tables")
                                    .font(.system(size: 55))
                                    .fontWeight(.bold)
                            }
                                
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    addingTable = true
                                    tableVM.error = ""
                                    tableVM.tableNumberInput = ""
                                    tableVM.seatsInput = 1
                                    tableVM.statusInput = "" // not really necessary according to logic
                                }) {
                                    Image(systemName: "plus.square.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.green)
                                }
                                .padding(.trailing, 10)
                            }
                            Spacer()
                        }
                    }
                    
                    ZStack {
                        if tableVM.tables == [] {
                            VStack(spacing: 10) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 50))
                                Text("No tables")
                                    .font(.system(size: 50))
                                    .fontWeight(.semibold)
                                Text("Create your first table by pressing the add icon.")
                                    .font(.system(size: 20))
                            }.padding(.bottom, 90)
                        }
                        
                        List {
                            ForEach(tableVM.tables) { table in
                                Button(action: {
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
                    .background(.red)
                
                ZStack {
                    VStack {
                        if addingTable {
                            Text("New Table")
                                .font(Font.custom("DIN Bold", size: 60))
                            
                            HStack {
                                Text("Table Number")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                TextField("", text: $tableVM.tableNumberInput)
                                    .background(.white)
                                    .frame(width: 100, height: 40)
                                    .cornerRadius(25)
                                    .multilineTextAlignment(.center)
                                    // From: https://stackoverflow.com/questions/58733003/how-to-create-textfield-that-only-accepts-numbers
                                    .keyboardType(.numberPad)
                                    .onReceive(Just(tableVM.tableNumberInput)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            tableVM.tableNumberInput = filtered
                                        }
                                    }
                            }.padding(.horizontal, 20)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Seats")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Stepper("\(tableVM.seatsInput)", value: $tableVM.seatsInput, in: 1...20)

                                    
                                }.padding(.horizontal, 20)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                tableVM.addTable()
                                if tableVM.error == "" {
                                    self.selectedTable = nil
                                    addingTable = false
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(30)
                                        .foregroundColor(Color.blue)
                                        .frame(width: 380, height: 100)
                                        .padding(.bottom, 10)
                                    
                                    Text("Add Table")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 10)
                                        .font(.system(size: 35))
                                }
                            }
                            
                            Text("\(tableVM.error)")
                                .foregroundColor(.red)
                            
                        } else if let selectedTable = selectedTable {
                            Text("Table \(selectedTable.id!)")
                                .font(Font.custom("DIN Bold", size: 60))
                            
                            Button(action: {
                                editingTableNumber = true
                            }) {
                                HStack {
                                    Image(systemName: "pencil.tip.crop.circle")
                                    Text("Edit Table Number")
                                }.font(.system(size: 20))
                            }.padding(.bottom, 30)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Seats")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Stepper("\(tableVM.seatsInput)", value: $tableVM.seatsInput, in: 1...20)
                                        /*.onChange(of: tableVM.seatsInput) { newValue in
                                            tableVM.tableNumberInput = self.selectedTable!.id!
                                            tableVM.editTable()
                                        }*/
                                    /*TextField("", value: $tableVM.seatsInput, formatter: NumberFormatter())
                                        .background(.white)
                                        .frame(width: 100, height: 40)
                                        .cornerRadius(25)
                                        .multilineTextAlignment(.center)*/
                                    
                                }.padding(.horizontal, 20)
                            }
                            
                            HStack {
                                Text("Status")
                                    .fontWeight(.bold)
                                
                                DropdownSelector(
                                    placeholder: "\(tableVM.statusInput)",
                                    options: TableView.options,
                                    onOptionSelected: { option in
                                        tableVM.statusInput = option.value
                                    }
                                )/*.onChange(of: tableVM.statusInput) { newValue in
                                    tableVM.tableNumberInput = self.selectedTable!.id!
                                    tableVM.editTable()
                                    }*/
                            }.padding(.horizontal, 20)
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
                                
                                Text("Remove table")
                                    .fontWeight(.bold)
                                
                                Button(action: {
                                    tableVM.tableNumberInput = selectedTable.id!
                                    confirmingDelete = true
                                }) {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 40))
                                }
                            }.padding(.horizontal, 20)

                            Button(action: {
                                tableVM.tableNumberInput = selectedTable.id!
                                tableVM.editTable()
                                self.selectedTable = nil
                            }) {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(30)
                                        .foregroundColor(Color.blue)
                                        .frame(width: 380, height: 85)
                                        .padding(.bottom, 10)
                                    
                                    Text("Save changes")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 10)
                                        .font(.system(size: 35))
                                }
                            }
                            
                        } else {
                            Text("Select a Table")
                                .font(Font.custom("DIN Bold", size: 60))
                        }
                        
                    }.frame(maxWidth: 450, maxHeight: 550)
                    .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                    .font(.system(size: 30))
                }
            }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .navigationBarHidden(true)
                //.ignoresSafeArea()
                .onAppear {
                    tableVM.getTables()
                }
            
        } else {
            ZStack {
                Color(red: 220/255, green: 220/255, blue: 220/255).ignoresSafeArea()
                RoundedRectangle(cornerRadius:20)
                    .frame(width: 400, height: 220)
                    .foregroundColor(.white)
                
                VStack {
                    if confirmingDelete {
                        Text("**Delete Table \(tableVM.tableNumberInput)?**")
                            .font(.system(size: 40))
                        Spacer()
                        HStack {
                            Button(action: {
                                confirmingDelete = false
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 40))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                tableVM.removeTable()
                                self.selectedTable = nil
                                confirmingDelete = false
                            }) {
                                Text("Delete")
                                    .foregroundColor(.red)
                                    .font(.system(size: 40))
                            }
                        }.padding(.horizontal, 50)

                    } else if editingTableNumber {
                        Text("**Edit Table Number**")
                            .font(.system(size: 30))
                        Text("Table \(self.selectedTable!.id!)")
                            .font(.system(size: 23))
                            .foregroundColor(.orange)
                        Spacer()
                        HStack {
                            Text("**New Number**")
                                .font(.system(size: 20))
                            Spacer()
                            TextField("", text: $tableVM.newTableNumberInput)
                                .frame(width: 150, height: 40)
                                .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                                .cornerRadius(25)
                                .multilineTextAlignment(.center)
                                // From: https://stackoverflow.com/questions/58733003/how-to-create-textfield-that-only-accepts-numbers
                                .keyboardType(.numberPad)
                                .onReceive(Just(tableVM.newTableNumberInput)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        tableVM.newTableNumberInput = filtered
                                    }
                                }
                        }.padding(.horizontal, 50)
                        Spacer()
                        HStack {
                            Button(action: {
                                tableVM.error = ""
                                editingTableNumber = false
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                tableVM.tableNumberInput = selectedTable!.id!
                                tableVM.editTableNumber()
                                if tableVM.error == "" {
                                    self.selectedTable = nil
                                    tableVM.newTableNumberInput = ""
                                    editingTableNumber = false
                                }
                            }) {
                                Text("Save Changes")
                                    .font(.system(size: 20))
                            }
                        }.padding(.horizontal, 50)
                  
                        
                        Text("\(tableVM.error)")
                            .foregroundColor(.red)
                    }
                }.frame(width: 400, height: 160)
            }
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView().previewInterfaceOrientation(.landscapeLeft)
    }
}
