//
//  ReservationView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI

private let twoColumnGrid = [
    GridItem(.fixed(250)),
    GridItem(.fixed(250)),
]

struct ReservationView: View {
    var horizontalSpacing: CGFloat = 48
    var verticalSpacing: CGFloat = 48
    
    func reserve() {
        
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                
                
                GeometryReader { geometry in
                            Path { path in
                                let numberOfHorizontalGridLines = Int(geometry.size.height / self.verticalSpacing)
                                let numberOfVerticalGridLines = Int(geometry.size.width / self.horizontalSpacing)
                                for index in 0...numberOfVerticalGridLines {
                                    let vOffset: CGFloat = CGFloat(index) * self.horizontalSpacing
                                    path.move(to: CGPoint(x: vOffset, y: 0))
                                    path.addLine(to: CGPoint(x: vOffset, y: geometry.size.height))
                                }
                                for index in 0...numberOfHorizontalGridLines {
                                    let hOffset: CGFloat = CGFloat(index) * self.verticalSpacing
                                    path.move(to: CGPoint(x: 0, y: hOffset))
                                    path.addLine(to: CGPoint(x: geometry.size.width, y: hOffset))
                                }
                            }
                            .stroke(Color.blue)
                }.ignoresSafeArea()
                
                Group {
                    ZStack {
                        Rectangle()
                            .frame(width: 98, height: 98)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .foregroundColor(.green)
                        
                        Text("2")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding(.bottom, 30)
                    }.offset(x: -310, y: -305)
                        
                    ZStack {
                        Rectangle()
                            .frame(width: 98, height: 98)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .foregroundColor(.red)
                        
                        Text("2")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding(.bottom, 30)
                    }.offset(x: -166, y: -305)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 98, height: 98)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .foregroundColor(.green)
                        
                        Text("2")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding(.bottom, 30)
                        
                        Menu("2") {
                            Button("Reserve", action: reserve)
                                
                        }
                        .foregroundColor(.green)
                            .offset(y: 2)
                        
                    }.offset(x: -22, y: -305)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 98, height: 98)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .foregroundColor(.red)
                        
                        Text("2")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding(.bottom, 30)
                    }.offset(x: 122, y: -305)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 98, height: 98)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .foregroundColor(.red)
                        
                        Text("2")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding(.bottom, 30)
                    }.offset(x: 266, y: -305)
                }
                
                Group {
                    ZStack {
                        Circle()
                            .strokeBorder(.black, lineWidth: 2)
                            .background(Circle().fill(.white))
                            .frame(width: 145, height: 145)
                            .padding(.bottom, 30)
                            .padding(.trailing, 40)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.trailing, 35)
                            .foregroundColor(.red)
                        
                        Text("3")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.trailing, 35)
                            .padding(.bottom, 30)
                    }.offset(x: -218, y: -89)
                    
                    ZStack {
                        Circle()
                            .strokeBorder(.black, lineWidth: 2)
                            .background(Circle().fill(.white))
                            .frame(width: 145, height: 145)
                            .padding(.bottom, 30)
                            .padding(.trailing, 40)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.trailing, 35)
                            .foregroundColor(.green)
                        
                        Text("3")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.trailing, 35)
                            .padding(.bottom, 30)
                    }.offset(x: 22, y: -89)
                    
                    ZStack {
                        Circle()
                            .strokeBorder(.black, lineWidth: 2)
                            .background(Circle().fill(.white))
                            .frame(width: 145, height: 145)
                            .padding(.bottom, 30)
                            .padding(.trailing, 40)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.trailing, 35)
                            .foregroundColor(.red)
                        
                        Text("3")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.trailing, 35)
                            .padding(.bottom, 30)
                    }.offset(x: 262, y: -89)
                }
                
                Group {
                    ZStack {
                        Rectangle()
                            .frame(width: 384, height: 144)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                            .padding(.leading, 270)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.leading, 280)
                            .foregroundColor(.red)
                        
                        Text("8")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.leading, 280)
                            .padding(.bottom, 30)
                    }.offset(x: 35, y: 391)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 193, height: 97)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                            .padding(.trailing, 80)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.trailing, 75)
                            .foregroundColor(.green)
                        
                        Text("4")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.trailing, 75)
                            .padding(.bottom, 30)
                    }.offset(x: -222, y: 415)
                }
                
                Group {
                    ZStack {
                        Rectangle()
                            .frame(width: 145, height: 145)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                            .padding(.leading, 50)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.leading, 50)
                            .foregroundColor(.green)
                        
                        Text("4")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.leading, 50)
                            .padding(.bottom, 30)
                    }.offset(x: 217, y: 151)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 145, height: 145)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                            .padding(.leading, 50)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.leading, 50)
                            .foregroundColor(.red)
                        
                        Text("4")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.leading, 50)
                            .padding(.bottom, 30)
                    }.offset(x: -23, y: 151)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 145, height: 145)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                            .padding(.leading, 50)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.leading, 50)
                            .foregroundColor(.green)
                        
                        Text("4")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.leading, 50)
                            .padding(.bottom, 30)
                    }.offset(x: -263, y: 151)
                }
                
                
            }.ignoresSafeArea()
            
            Spacer()
            
            VStack {
                
                Text("Tables")
                    .font(Font.custom("DIN Bold", size: 60))
                    .padding(.bottom, 100)
                
                
                
                LazyVGrid(columns: twoColumnGrid) {
                    ZStack {
                        Rectangle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .foregroundColor(.green)
                        
                        Text("2")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 30)
                    }.padding(.bottom, 20)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 100)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                            .padding(.trailing, 80)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.trailing, 75)
                            .foregroundColor(.green)
                        
                        Text("4")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.trailing, 75)
                            .padding(.bottom, 30)
                    }.padding(.bottom, 20)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                            .padding(.leading, 50)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.leading, 50)
                            .foregroundColor(.green)
                        
                        Text("4")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.leading, 50)
                            .padding(.bottom, 30)
                    }.padding(.bottom, 20)
                    
                    ZStack {
                        Circle()
                            .strokeBorder(.black, lineWidth: 2)
                            .background(Circle().fill(.white))
                            .frame(width: 150, height: 150)
                            .padding(.bottom, 30)
                            .padding(.trailing, 40)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.trailing, 35)
                            .foregroundColor(.green)
                        
                        Text("3")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.trailing, 35)
                            .padding(.bottom, 30)
                    }.padding(.bottom, 20)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 370, height: 150)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .padding(.bottom, 30)
                            .padding(.leading, 270)
                        
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 30)
                            .padding(.leading, 280)
                            .foregroundColor(.green)
                        
                        Text("8")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.leading, 280)
                            .padding(.bottom, 30)
                    }.padding(.bottom, 20)
                        
                }.padding(.top, -30)
                
                ZStack {
                    Rectangle()
                        .cornerRadius(30)
                        .foregroundColor(Color.blue)
                        .frame(width: 380, height: 100)
                        .padding(.bottom, 10)
                    
                    Text("Save Layout")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .font(.system(size: 35))
                }.padding(.top, -30)
                
            }.frame(maxWidth: 450, maxHeight: .infinity)
                .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .font(.system(size: 30))
        }
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
