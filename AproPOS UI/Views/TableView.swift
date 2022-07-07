//
//  TableView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 6/7/22.
//

import SwiftUI

struct TableView: View {
    @StateObject private var tableVM = TableViewModel()
    
    @State private var textFieldInput = ""
    @State private var textEditorInput = " Order placed - 5/3/2022"
    @State private var selectedTable: TableModel? = nil
    @State private var addingTable: Bool = false
    
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
        HStack (spacing: 0) {
            VStack {
                
                HStack {
                    Text("Items")
                        .font(.system(size: 55))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: show add table
                        addingTable = true
                        tableVM.tableNumberInput = ""
                        tableVM.seatsInput = 1
                        tableVM.statusInput = "" // not really necessary according to logic
                    }) {
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                    }
                }
                
                ZStack {
                    List {
                        ForEach(tableVM.tables) { table in
                            Button(action: {
                                addingTable = false
                                selectedTable = table
                                tableVM.seatsInput = selectedTable!.seats
                                tableVM.statusInput = selectedTable!.status
                            }) {
                                IndividualTableView(table: table)
                            }
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
                            self.selectedTable = nil
                            addingTable = false
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
                        
                    } else if let selectedTable = selectedTable {
                        Text("Table \(selectedTable.id!)")
                            .font(Font.custom("DIN Bold", size: 60))
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Seats")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Stepper("\(tableVM.seatsInput)", value: $tableVM.seatsInput, in: 1...20)
                                
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
                            )
                        }.padding(.horizontal, 20)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Text("Remove table")
                                .fontWeight(.bold)
                            
                            Button(action: {
                                tableVM.tableNumberInput = selectedTable.id!
                                tableVM.removeTable()
                                self.selectedTable = nil
                            }) {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 40))
                            }
                        }.padding(.horizontal, 20)

                        Button(action: {
                            tableVM.tableNumberInput = selectedTable.id!
                            tableVM.editTable()
                        }) {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color.blue)
                                    .frame(width: 380, height: 85)
                                    .padding(.bottom, 10)
                                
                                Text("Edit Table")
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
                    
                }.frame(maxWidth: 450, maxHeight: 450)//.infinity)
                .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .font(.system(size: 30))
                
            }
            
            
        }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
            .navigationBarHidden(true)
            //.ignoresSafeArea()
            .onAppear {
                tableVM.getTables()
            }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView().previewInterfaceOrientation(.landscapeLeft)
    }
}
