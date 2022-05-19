//
//  MenuView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI

private let fourRowGrid = [
    GridItem(.fixed(250)),
    GridItem(.fixed(250)),
    GridItem(.fixed(250)),
    GridItem(.fixed(250))
]

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}

struct MenuView: View {
    
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var priceInput = "18.00"
    @State private var minuteInput = "10"
    @State private var secondInput = "00"
    
    var body: some View {
        HStack (spacing: 0) {
            
            ScrollView(showsIndicators: false) {
                Image(systemName: "plus.square.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.green)
                    .offset(x: 430, y: -60)
                    .padding(.bottom, 15)
                
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
                            
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
                            Image(systemName: "pencil.tip.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .offset(x: -115, y: -90)
                            
                        }
                    }
                    
                    

                }.padding(.top, -5)
                    .offset(y: -60)
            }.navigationBarHidden(true)
            
            
            
            Spacer()
            
            VStack {
                Text("Menu Item")
                    .font(Font.custom("DIN Bold", size: 60))
                    .padding(.top, 10)
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.orange)
                        .frame(width: 250, height: 50)
                        .padding(.bottom, 17)
                        .cornerRadius(20)
                    
                    Text("Mac N Cheese")
                        .font(Font.custom("DIN Bold", size: 35))
                        .padding(.bottom, 20)
                        .foregroundColor(.white)
                    
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        Text("Ingredients")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                        
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 370, height: 400)
                            
                            
                            Group {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.yellow)
                                        .cornerRadius(10)
                                        .frame(width: 370, height: 45)
                                    
                                    HStack {
                                        Text("300g")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                        
                                        Text("Macaroni")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                    }
                    
                                }.offset(y: -180)
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.green)
                                        .cornerRadius(10)
                                        .frame(width: 370, height: 45)
                                    
                                    HStack {
                                        Text("200g")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                        
                                        Text("Bacon")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                    }
                    
                                }.offset(y: -133)
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.yellow)
                                        .cornerRadius(10)
                                        .frame(width: 370, height: 45)
                                    
                                    HStack {
                                        Text("60g")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                        
                                        Text("Butter")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                    }
                    
                                }.offset(y: -86)
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.green)
                                        .cornerRadius(10)
                                        .frame(width: 370, height: 45)
                                    
                                    HStack {
                                        Text("60g")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                        
                                        Text("All-Purpose Flour")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                    }
                    
                                }.offset(y: -39)
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.yellow)
                                        .cornerRadius(10)
                                        .frame(width: 370, height: 45)
                                    
                                    HStack {
                                        Text("500mL")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                        
                                        Text("Milk")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                    }
                    
                                }.offset(y: 8)
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.green)
                                        .cornerRadius(10)
                                        .frame(width: 370, height: 45)
                                    
                                    HStack {
                                        Text("500g")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                        
                                        Text("Cheddar Cheese")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                    }
                    
                                }.offset(y: 55)
                                    
                            }
                            
                        
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(red: 194/255, green: 194/255, blue: 250/255))
                                    .frame(width: 370, height: 45)
                                    .offset(y: 180)
                                
                                HStack {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.white)
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.white)

                                }.offset(x: 135, y: 180)
                            }
                        
                            
                        }
                        
                        HStack {
                            Text("Price")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .frame(width: 72)
                            
                            Text("$")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .offset(x: 158)
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(25)
                                    .frame(width: 110)
                                    .offset(x: 63)
                                
                                TextField("00.00", text: $priceInput)
                                    .offset(x: 170)
                            }
                        }
                        
                        HStack {
                            Text("Serving Time")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .frame(width: 183)
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 70)
                                    .cornerRadius(25)
                                    .offset(x: 13)
                                
                                TextField("00", text: $minuteInput)
                                    .offset(x: 41)
                            }
                
                            Text(":")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 70)
                                    .cornerRadius(25)
                                    .offset(x: -15)
                                
                                TextField("00", text: $secondInput)
                                    .offset(x: 14)
                            }
                            
                        }
                        
                        HStack {
                            Text("Warnings")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .frame(width: 133)
                            
                            Image(systemName: "hare")
                                .foregroundColor(.gray)
                                .offset(x: 143)
                            
                            Image(systemName: "leaf.arrow.circlepath")
                                .foregroundColor(.gray)
                                .offset(x: 140)
                            
                        }
                        
                        Text("Image")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .offset(x: 3)
                        
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                    
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
                }.frame(width: 400, height: 800)
                    
                
                
                
            }.frame(maxWidth: 450, maxHeight: .infinity)
            .background(Color(red: 245/255, green: 245/255, blue: 220/255))
            .font(.system(size: 30))
            
        }.navigationBarBackButtonHidden(true)

    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
