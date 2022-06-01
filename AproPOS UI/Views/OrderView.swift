//
//  OrdersView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI

struct OrderView: View {
    @StateObject private var orderVM = OrderViewModel()
    
    func served() {}
    
    var body: some View {
        NavigationView {
            HStack (spacing: 0) {
                VStack {
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(.black, lineWidth: 2)
                            .frame(width: 450, height: 400)
                        VStack(alignment: .leading) {
                            ZStack {
                                Text("Table 24")
                                    .fontWeight(.bold)
                                    .font(.system(size: 50))
                                    .padding(.bottom, 10)
                                    .padding(.leading, 60)
                                Menu("Test") {
                                    Button("✅ Served", action: served).font(.system(size: 30))
                                    .offset(y: 30)
                                    .foregroundColor(.white)
                                }.offset(y: 40)
                                    .foregroundColor(.white)
                            }
                            
                            Text("**2**  Caesar Salad")
                                .strikethrough()
                            Text("**1**  Chicken Penne Pasta").strikethrough()
                            Text("**1**  Sirloin Steak")
                            Text("     Medium well")
                                .foregroundColor(.gray)
                            HStack {
                                Text("~~**3**  Chicken Schnitzel~~ ")
                                Text("**[1]**")
                                    .foregroundColor(Color.red)
                            }
                            Text("Estimated: 18:00")
                                .foregroundColor(Color.brown)
                                .padding(.top, 10)
                            Text("Elapsed: 14:33")
                                .foregroundColor(Color.green)
                                .fontWeight(.semibold)
                        }.padding(20)
                        .font(.system(size: 30))
    
                        NavigationLink (destination: OrderView()) {
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 42))
                                .padding(.top, 340)
                                .padding(.leading, 260)
                        }
                        
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 40))
                            .padding(.top, 340)
                            .padding(.leading, 360)
                    }
                    
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(.orange, lineWidth: 4)
                            .frame(width: 450, height: 465)
                        VStack(alignment: .leading) {
                            Text("Table 17")
                                .fontWeight(.bold)
                                .font(.system(size: 50))
                                .padding(.bottom, 10)
                                .padding(.leading, 50)
                                .foregroundColor(.orange)
                            Text("2  Mac N Cheese")
                                .strikethrough()
                            VStack(alignment: .leading) {
                                Text("1  Porterhouse Steak")
                                    .foregroundColor(Color.red)
                                    .fontWeight(.semibold)
                                Text("     Medium Rare")
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text("2  Rib Eye Steak")
                                    .strikethrough()
                                Text("     Medium well")
                                    .strikethrough()
                                    .foregroundColor(.gray)
                                Text("     Medium")
                                    .strikethrough()
                                    .foregroundColor(.gray)
                            }
                            Text("2  French Fries")
                                .strikethrough()
                            Text("Estimated: 25:00")
                                .foregroundColor(Color.brown)
                                .padding(.top, 7)
                            Text("Elapsed: 27:11")
                                .foregroundColor(Color.red)
                                .fontWeight(.bold)
                        }.padding(20)
                        .font(.system(size: 30))
    
                        NavigationLink (destination: OrderView()) {
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 42))
                                .padding(.top, 405)
                                .padding(.leading, 260)
                        }
                        
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 40))
                            .padding(.top, 405)
                            .padding(.leading, 360)
                    }.padding(.top, 20)
                    
                    Spacer()
                }.padding(30)
                .padding(.leading, 20)
                
                VStack {
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(.orange, lineWidth: 4)
                            .frame(width: 450, height: 530)
                        VStack(alignment: .leading) {
                            Text("Table 14")
                                .fontWeight(.bold)
                                .font(.system(size: 50))
                                .padding(.bottom, 10)
                                .padding(.leading, 65)
                                .foregroundColor(.orange)
                            Text("1  Garlic Mashed Potato")
                                .strikethrough()
                            HStack {
                                Text("2  Spaghetti Carbonara")
                                    .strikethrough()
                                Text("**[1]**").foregroundColor(Color.red)
                                    .fontWeight(.semibold)
                            }
                            VStack(alignment: .leading) {
                                Text("1  New York Strip")
                                    .strikethrough()
                                Text("     Medium")
                                    .foregroundColor(.gray)
                                    .strikethrough()
                            }
                            Text("1  Chicken Schnitzel")
                                .strikethrough()
                            VStack(alignment: .leading) {
                                Text("2  Sirloin Steak")
                                    .foregroundColor(Color.red)
                                    .fontWeight(.semibold)
                                Text("     Well done")
                                    .strikethrough()
                                    .foregroundColor(.gray)
                                Text("     Medium Rare")
                                    .foregroundColor(Color.red)
                                    .fontWeight(.semibold)
                            }
                            Text("1  Red Wine")
                                .strikethrough()
                            Text("Estimated: 23:30")
                                .foregroundColor(Color.brown)
                                .padding(.top, 2)
                            Text("Elapsed: 24:52")
                                .foregroundColor(Color.red)
                                .fontWeight(.bold)
                        }.padding(20)
                        .font(.system(size: 30))
    
                        NavigationLink (destination: OrderView()) {
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 42))
                                .padding(.top, 470)
                                .padding(.leading, 260)
                        }
                        
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 40))
                            .padding(.top, 470)
                            .padding(.leading, 360)
                    }.padding(.top, -12)
                        .padding(.bottom, 20)
                    
                    
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(.black, lineWidth: 2)
                            .frame(width: 450, height: 340)
                        VStack(alignment: .leading) {
                            Text("Table 12")
                                .fontWeight(.bold)
                                .font(.system(size: 50))
                                .padding(.bottom, 10)
                                .padding(.leading, 60)
                            Text("**2**  Caesar Salad")
                                .strikethrough()
                            Text("**1**  Chicken Penne Pasta").strikethrough()
                            Text("**1**  Chicken Schnitzel")
                            Text("Estimated: 10:00")
                                .foregroundColor(Color.brown)
                                .padding(.top, 10)
                            Text("Elapsed: 8:14")
                                .foregroundColor(Color.green)
                                .fontWeight(.semibold)
                        }.padding(20)
                        .font(.system(size: 30))
                        
                        NavigationLink (destination: OrderView()) {
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 42))
                                .padding(.top, 280)
                                .padding(.leading, 260)
                        }
                        
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 40))
                            .padding(.top, 280)
                            .padding(.leading, 360)
                    }.padding(.top, -15)
                
                    
                    Spacer()
                }
                .padding(30)
                .padding(.leading, -20)
                
                Spacer()
                
                NavigationLink (destination: NewOrderView()) {
                    VStack {
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 100))
                            .foregroundColor(Color.blue)
                        Text("New Order")
                            .font(Font.custom("DIN Bold", size: 80))
                            .foregroundColor(Color.white)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }
                }.navigationBarHidden(true)
                    .frame(maxWidth: 300, maxHeight: .infinity)
                    .background(Color(red: 246/255, green: 188/255, blue: 71/255))
                
                
                
            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
