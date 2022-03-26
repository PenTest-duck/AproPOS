//
//  NewOrderView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 7/3/22.
//

import SwiftUI

private let fourRowGrid = [
    GridItem(.fixed(250)),
    GridItem(.fixed(250)),
    GridItem(.fixed(250)),
    GridItem(.fixed(250))
]

struct NewOrderView: View {
    var body: some View {
        HStack (spacing: 0) {
            
            ScrollView(showsIndicators: false) {
                LazyHGrid(rows: fourRowGrid, alignment: .bottom) {
                    Group {
                        ZStack {
                            
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("caesar-salad")
                                .resizable()
                                .frame(width: 300, height: 250)
                            Image(systemName: "leaf.arrow.circlepath")
                                .font(.system(size: 50))
                                .foregroundColor(Color.green)
                                .offset(x: 115, y: -90)
                            Text("Caesar Salad")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("mac-n-cheese")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 250)
                                .clipped()
                            Text("Mac N Cheese")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("chicken-penne-pasta")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 250)
                                .clipped()
                            Text("Chicken Penne Pasta")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("spaghetti-carbonara")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 250)
                                .clipped()
                            Text("Spaghetti Carbonara")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                    }
                    
                    Group {
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("sirloin-steak")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 250)
                                .clipped()
                            Text("Sirloin Steak")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("porterhouse")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 250)
                                .clipped()
                            Text("Porterhouse")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("rib-eye")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 250)
                                .clipped()
                            Text("Rib Eye")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("new-york-strip")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 250)
                                .clipped()
                            Text("New York Strip")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                    }
                    
                    Group {
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("garlic-mashed-potato")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 250)
                                .clipped()
                            Image(systemName: "leaf.arrow.circlepath")
                                .font(.system(size: 50))
                                .foregroundColor(Color.green)
                                .offset(x: 115, y: -90)
                            Text("Garlic Mashed Potato")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.red)
                            Image("chicken-schnitzel")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 250)
                                .clipped()
                            Text("Chicken Schnitzel")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background(Color.red)
                                .offset(y: 85)
                            
                        }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.gray)
                            Text("Red Wine")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                //.background(Color.red)
                            
                        }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 250)
                                .foregroundColor(.gray)
                            Text("Champagne")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                //.background(Color.red)
                            
                        }
                    }
                    
                    

                }.padding(.top, -5)
            }.navigationBarHidden(true)
            
            
            
            Spacer()
            
            VStack {
                Text("New Order")
                    .font(Font.custom("DIN Bold", size: 60))
                    .padding(.top, 10)
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.orange)
                        .frame(width: 170, height: 50)
                        .padding(.bottom, 17)
                        .cornerRadius(20)
                    
                    Text("Table 15")
                        .font(Font.custom("DIN Bold", size: 35))
                        .padding(.bottom, 20)
                        .foregroundColor(.white)
                    
                }
                    
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "arrow.up.circle")
                        Image(systemName: "arrow.down.circle")
                        Text(" **2**  Caesar Salad")
                    }.padding(.bottom, 1)
                    HStack {
                        Image(systemName: "arrow.up.circle")
                        Image(systemName: "arrow.down.circle")
                        Text(" **1**  Chicken Schnitzel")
                    }.padding(.bottom, 1)
                    VStack {
                        HStack {
                            Image(systemName: "arrow.up.circle")
                            Image(systemName: "arrow.down.circle")
                            Text(" **2**  Sirloin Steak")
                        }
                        Text("                  Medium well")
                            .foregroundColor(.gray)
                        Text("            Well done")
                            .foregroundColor(.gray)
                    }.padding(.bottom, 1)
                    HStack {
                        Image(systemName: "arrow.up.circle")
                        Image(systemName: "arrow.down.circle")
                        Text(" **1**  Red Wine")
                    }.padding(.bottom, 1)
                    
                    Spacer()
                    
                    
                    ZStack {
                        Rectangle()
                            .cornerRadius(30)
                            .foregroundColor(Color.blue)
                            .frame(width: 380, height: 100)
                            .padding(.bottom, 10)
                            
                        Text("Submit")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                            .font(.system(size: 35))
                    }
                }
                
                
            }.frame(maxWidth: 450, maxHeight: .infinity)
            .background(Color(red: 245/255, green: 245/255, blue: 220/255))
            .font(.system(size: 30))
            
        }.navigationBarBackButtonHidden(true)
    }
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView().previewInterfaceOrientation(.landscapeLeft)
    }
}
