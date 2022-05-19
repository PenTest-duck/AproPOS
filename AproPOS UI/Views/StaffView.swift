//
//  StaffView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 15/3/22.
//

import SwiftUI

struct StaffView: View {
    @State private var commentInput = "   Pay raise from 1/4/2022"
    @State private var usernameInput = "    delwood"
    @State private var passwordInput = "       ●●●●●●●●●"
    
    init() {
            UITextView.appearance().backgroundColor = .clear
        }

    
    var body: some View {
        HStack(spacing: 0) {
            
            ScrollView {
            
            VStack(alignment: .leading) {
                Text("Daniel Elwood")
                    .fontWeight(.bold)
                    .font(.system(size: 60))
                    .padding(.leading, 30)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Roles: ")
                            .fontWeight(.semibold)
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.orange)
                                .frame(width: 230, height: 55)
                                .cornerRadius(25)
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.white)
                                .offset(x: -80)
                            Text("Manager")
                                .foregroundColor(.white)
                                .offset(x: 20)
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.green)
                                .frame(width: 200, height: 55)
                                .cornerRadius(25)
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.white)
                                .offset(x: -65)
                            Text("Kitchen")
                                .foregroundColor(.white)
                                .offset(x: 20)
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 150, height: 55)
                                .cornerRadius(25)
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.white)
                                .offset(x: -40)
                            Text("Staff")
                                .foregroundColor(.white)
                                .offset(x: 20)
                        }
                        
                        Image(systemName: "plus.circle")
                            .foregroundColor(.purple)
                            .font(.system(size: 50))
                    }.font(.system(size: 35))
                    
                    HStack {
                        Text("Shift")
                            .fontWeight(.semibold)
                            .font(.system(size: 35))
                        
                        Image(systemName: "pencil.tip.crop.circle")
                            .font(.system(size: 35))
                            .foregroundColor(.blue)
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255))
                            .frame(height: 200)
                            .frame(maxWidth: 850)
                            .cornerRadius(25)
                        
                        Text("Mon            Tue            Wed            Thu            Fri            Sat            Sun")
                            .font(.system(size: 30))
                            .offset(y: -60)
                        
                        VStack {
                            Text("15:00")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                            Text("~")
                                
                            Text("20:00")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                        }.font(.system(size: 30))
                            .offset(x: -376, y: 25)
                        
                        VStack {
                            Text("15:00")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                            Text("~")
                                
                            Text("20:00")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                        }.font(.system(size: 30))
                            .offset(x: -245, y: 25)
                        
                        VStack {
                            Text("17:00")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                            Text("~")
                                
                            Text("22:00")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                        }.font(.system(size: 30))
                            .offset(x: -115, y: 25)
                        
                        VStack {
                            Text("15:00")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                            Text("~")
                                
                            Text("20:00")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                        }.font(.system(size: 30))
                            .offset(x: 20, y: 25)
                        
                        VStack {
                            Text("15:00")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                            Text("~")
                                
                            Text("20:00")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                        }.font(.system(size: 30))
                            .offset(x: 140, y: 25)
                        
                        VStack {
                            Text("11:00")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                            Text("~")
                                
                            Text("18:00")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                        }.font(.system(size: 30))
                            .offset(x: 255, y: 25)
                        
                        VStack {
                            Text("--:--")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                            Text("~")
                                
                            Text("--:--")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                        }.font(.system(size: 30))
                            .offset(x: 380, y: 25)
                        
                    }
                    
                    HStack {
                        Text("Wage: ")
                            .fontWeight(.semibold)
                            .font(.system(size: 35))
                        
                        Text("$")
                            .font(.system(size: 35))
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255))
                                .frame(width: 140, height: 50)
                                .cornerRadius(25)
                            
                            Text("26.20")
                                .font(.system(size: 35))
                        }.offset(x: -5)
                            
                        Text("/ hr")
                            .font(.system(size: 35))
                            .fontWeight(.semibold)
                    }
                    
                    Text("Comments: ")
                        .fontWeight(.semibold)
                        .font(.system(size: 35))
                    
                    TextEditor(text: $commentInput)
                        .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                        .foregroundColor(.gray)
                        .cornerRadius(25)
                        .frame(width: 850, height: 220)
                        .font(.system(size: 25))
                    
                    HStack {
                        Text("Username: ")
                            .fontWeight(.semibold)
                            .font(.system(size: 35))
                        
                        TextField("", text: $usernameInput)
                            .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                            .font(.system(size: 35))
                            .frame(maxWidth: 200)
                            .cornerRadius(20)
                        
                    }
                    
                    HStack {
                        Text("Password: ")
                            .fontWeight(.semibold)
                            .font(.system(size: 35))
                        
                        TextField("", text: $passwordInput)
                            .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                            .font(.system(size: 30))
                            .frame(maxWidth: 350)
                            .cornerRadius(20)
                        
                    }
                    
                    Image(systemName: "scissors")
                        .foregroundColor(.red)
                        .font(.system(size: 35))
                        .padding(.top, 10)
                        .offset(x: 800, y: -70)
                    
                }.padding(.leading, 30)
                    .padding(.top, 1)
                
                Spacer ()
            }
            }
            
            Spacer()
            
            VStack {
                
                Text("Staff")
                    .font(Font.custom("DIN Bold", size: 60))
                
                List {
                    Text("Daniel Elwood")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    Text("Jaydan Lovell")
                    Text("Kia Hayes")
                    Text("Tyson Wilder")
                    Text("Shyla Gale")
                    Text("Dario Moody")
                    Text("Faith Liu")
                    Text("Sarina Perry")
                    Text("Klara Cote")
                    Text("Nancy Gough")
                }
                
                Image(systemName: "plus.square.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 50))
                    .offset(x: 170, y: -100)
                
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
                }.padding(.top, -30)
                
            }.frame(maxWidth: 450, maxHeight: .infinity)
                .background(Color(red: 242/255, green: 242/255, blue: 248/255))
                .font(.system(size: 30))
        }.navigationBarHidden(true)
    }
}

struct StaffView_Previews: PreviewProvider {
    static var previews: some View {
        StaffView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
