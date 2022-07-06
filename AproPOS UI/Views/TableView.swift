//
//  TableView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 6/7/22.
//

import SwiftUI

struct TableView: View {
    
    @State private var textFieldInput = ""
    @State private var textEditorInput = " Order placed - 5/3/2022"
    
    @StateObject private var tableVM = TableViewModel()
    
    var body: some View {
        HStack (spacing: 0) {
            VStack {
                ZStack {
                    List {
                        ForEach(tableVM.tables) { table in
                            IndividualTableView(table: table)
                        }
                    }.listStyle(PlainListStyle())
                }
                
            }.background(Color(red: 242/255, green: 242/255, blue: 248/255))
            
            Spacer()
            
            ZStack {
            VStack {
                Text("Rib Eye")
                    .font(Font.custom("DIN Bold", size: 60))
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("Units")
                            .fontWeight(.bold)
                            .offset(y: 3)
                        
                        Spacer ()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 260, height: 40)
                                .cornerRadius(25)
                            
                            HStack {
                                Text("**kg**")
                                Text("|  L  |  btl  |  svg")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                    }.padding(.leading, 20)
                        .padding(.trailing, 20)
                        .frame(height: 50)
                    
                    HStack {
                        Text("Current Stock")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        TextField("12", text: $textFieldInput)
                            .background(.white)
                            .frame(width: 100, height: 40)
                            .cornerRadius(25)
                            .multilineTextAlignment(.center)
                        
                    }.padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    HStack {
                        Text("Minimum Threshold")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        TextField("30", text: $textFieldInput)
                            .background(.white)
                            .frame(width: 100, height: 40)
                            .cornerRadius(25)
                            .multilineTextAlignment(.center)
                        
                    }.padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    HStack {
                        Text("Cost Per Unit")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("$")
                            .fontWeight(.bold)
                        
                        TextField("20.00", text: $textFieldInput)
                            .background(.white)
                            .frame(width: 140, height: 40)
                            .cornerRadius(25)
                            .multilineTextAlignment(.center)
                        
                    }.padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    HStack {
                        Text("Storage requirements")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image(systemName: "slash.circle")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        Image(systemName: "clock")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        Image(systemName: "snow")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                        
                        
                    }.padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    VStack {
                        Text("Comments")
                            .fontWeight(.bold)
                        
                        TextEditor(text: $textEditorInput)
                            .foregroundColor(.gray)
                            .font(.system(size: 25))
                            .background(.white)
                            .frame(height: 200)
                            .cornerRadius(25)
                            .multilineTextAlignment(.leading)
                    }.padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                }
                
                Spacer()
            
                ZStack {
                    Rectangle()
                        .cornerRadius(30)
                        .foregroundColor(Color.blue)
                        .frame(width: 380, height: 100)
                        .padding(.bottom, 10)
                    
                    Text("Save Changes")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .font(.system(size: 35))
                }
                
                
            }.frame(maxWidth: 450, maxHeight: .infinity)
            .background(Color(red: 242/255, green: 242/255, blue: 248/255))
            .font(.system(size: 30))
            .offset(y: -50)
                
                
            Rectangle()
                .frame(maxWidth: 450, maxHeight: 150)
                .foregroundColor(Color(red: 242/255, green: 242/255, blue: 248/255))
                .offset(y: 460)
            }
            
            
        }.navigationBarHidden(true)
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
