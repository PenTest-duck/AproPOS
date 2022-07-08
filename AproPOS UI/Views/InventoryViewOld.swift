//
//  InventoryViewOld.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI

private let twoColumnGrid = [
    GridItem(.fixed(250)),
    GridItem(.fixed(250)),
]

struct InventoryViewOld: View {
    @StateObject private var inventoryVM = InventoryViewModel()
    
    @State private var textFieldInput: String = ""
    @State private var textEditorInput: String = ""
    
    @State private var selectedIngredient: IngredientModel? = nil
    @State private var addingIngredient: Bool = false
    @State private var confirmingDelete: Bool = false
    
    var body: some View {
        
        HStack (spacing: 0) {
            
            VStack {
                ZStack {
                    
                    List {
                        Group {
                        HStack {
                            Text("Sirloin Beef")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("51 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                            
                            Text("/ 35 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                        }.listRowBackground(Color.green)
                        
                        HStack {
                            Text("Porterhouse Beef")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("78 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                            
                            Text("/ 55 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                        }.listRowBackground(Color.green)
                        
                        HStack {
                            Text("Rib Eye")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            
                            
                            Text("12 kg")
                                .foregroundColor(.purple)
                            
                            Text("/ 30 kg")
                                .foregroundColor(.purple)
                        }.listRowBackground(Color.yellow)
                                .font(.system(size: 30))
                        
                        HStack {
                            Text("New York Strip")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("56 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                            
                            Text("/ 35 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                        }.listRowBackground(Color.green)
                        
                        HStack {
                            Text("Chicken Breast")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("25 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                            
                            Text("/ 15 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                        }.listRowBackground(Color.green)
                        
                        HStack {
                            Text("Chicken Breast Schnitzel")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Image(systemName: "xmark.octagon.fill")
                                .foregroundColor(.orange)
                            
                            Text("0 kg")
                                .foregroundColor(.purple)
                            
                            Text("/ 25 kg")
                                .foregroundColor(.purple)
                        }.listRowBackground(Color.red)
                        .font(.system(size: 30))
                        
                        HStack {
                            Text("Bacon")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("20 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                            
                            Text("/ 10 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                        }.listRowBackground(Color.green)
                        
                        HStack {
                            Text("Assorted Salad")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            
                            Text("53 svg")
                                .foregroundColor(.purple)
                            
                            Text("/ 60 svg")
                                .foregroundColor(.purple)
                        }.listRowBackground(Color.yellow)
                                .font(.system(size: 30))
                        
                        HStack {
                            Text("Butter")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("14 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                            
                            Text("/ 10 kg")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                        }.listRowBackground(Color.green)
                        
                        HStack {
                            Text("Milk")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("18 L")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                            
                            Text("/ 10 L")
                                .foregroundColor(.purple)
                                .font(.system(size: 30))
                        }.listRowBackground(Color.green)
                        }
                        
                        Group {
                            HStack {
                                Text("Red Wine")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Image(systemName: "xmark.octagon.fill")
                                    .foregroundColor(.orange)
                                
                                Text("0 btl")
                                    .foregroundColor(.purple)
                                
                                Text("/ 50 btl")
                                    .foregroundColor(.purple)
                            }.listRowBackground(Color.red)
                            .font(.system(size: 30))
                            
                            
                            HStack {
                                Text("Champagne")
                                    .font(.system(size: 30))
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Text("40 btl")
                                    .foregroundColor(.purple)
                                    .font(.system(size: 30))
                                
                                Text("/ 25 btl")
                                    .foregroundColor(.purple)
                                    .font(.system(size: 30))
                            }.listRowBackground(Color.green)
                        }
                    }.padding(.top, 30)
                    
                    Text("Items")
                        .font(.system(size: 55))
                        .fontWeight(.bold)
                        .offset(x: 0, y: -470)
                    
                    Image(systemName: "plus.square.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                        .offset(x: 410, y: -470)
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

    }
}

struct InventoryViewOld_Previews: PreviewProvider {
    static var previews: some View {
        InventoryViewOld()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
