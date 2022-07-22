//
//  AnalyticsView.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/2/22.
//

import SwiftUI



struct LineView: View {
    @StateObject private var analyticsVM = AnalyticsViewModel()
    var dataPoints: [Double]
    
    var highestPoint: Double {
        let max = dataPoints.max() ?? 1.0
        if max == 0 { return 1.0 }
        return max
    }
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: height * self.ratio(for: 0)))
                
                for index in 1..<dataPoints.count {
                    path.addLine(to: CGPoint(
                        x: CGFloat(index) * width / CGFloat(dataPoints.count - 1),
                        y: height * self.ratio(for: index)))
                }
            }
            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineJoin: .round))
        }
        .padding(.vertical)
    }
    
    private func ratio(for index: Int) -> Double {
        dataPoints[index] / highestPoint
    }
}

struct LineChartCircleView: View {
    var dataPoints: [Double]
    var radius: CGFloat
    
    var highestPoint: Double {
        let max = dataPoints.max() ?? 1.0
        if max == 0 { return 1.0 }
        return max
    }
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: (height * self.ratio(for: 0)) - radius))
                
                path.addArc(center: CGPoint(x: 0, y: height * self.ratio(for: 0)),
                            radius: radius, startAngle: .zero,
                            endAngle: .degrees(360.0), clockwise: false)
                
                for index in 1..<dataPoints.count {
                    path.move(to: CGPoint(
                        x: CGFloat(index) * width / CGFloat(dataPoints.count - 1),
                        y: height * dataPoints[index] / highestPoint))
                    
                    path.addArc(center: CGPoint(
                        x: CGFloat(index) * width / CGFloat(dataPoints.count - 1),
                        y: height * self.ratio(for: index)),
                                radius: radius, startAngle: .zero,
                                endAngle: .degrees(360.0), clockwise: false)
                }
            }
            .stroke(Color.accentColor, lineWidth: 2)
        }
        .padding(.vertical)
    }
    
    private func ratio(for index: Int) -> Double {
        dataPoints[index] / highestPoint
    }
}

struct LineChartView: View {
    var dataPoints: [Double]
    var lineColor: Color = .blue
    var outerCircleColor: Color = .blue
    var innerCircleColor: Color = .white
    
    var body: some View {
        ZStack {
            LineView(dataPoints: dataPoints)
                .accentColor(lineColor)
            
            LineChartCircleView(dataPoints: dataPoints, radius: 3.0)
                .accentColor(outerCircleColor)
            
            LineChartCircleView(dataPoints: dataPoints, radius: 1.0)
                .accentColor(innerCircleColor)
        }
    }
}

struct ProfitGraphView: View {
    @State var dataPoints: [Double] = [15, 2, 7, 16, 32, 39, 5, 3, 25, 21, 28]
    
    var body: some View {
        LineChartView(dataPoints: dataPoints)
            .frame(height: 200)
            .padding(4)
            .background(Color.green.opacity(0.1).cornerRadius(16))
            .padding()
    }
}

struct CustomerGraphView: View {
    @State var dataPoints: [Double] = [8, 18, 10, 20, 38, 44, 2, 10, 19, 17, 35]
    
    var body: some View {
        LineChartView(dataPoints: dataPoints)
            .frame(height: 200)
            .padding(4)
            .background(Color.yellow.opacity(0.1).cornerRadius(16))
            .padding()
    }
}

struct OrdersGraphView: View {
    @State var dataPoints: [Double] = [20, 30, 15, 26, 29, 44, 11, 4, 16, 9, 38]
    
    var body: some View {
        LineChartView(dataPoints: dataPoints)
            .frame(height: 200)
            .padding(4)
            .background(Color.orange.opacity(0.1).cornerRadius(16))
            .padding()
    }
}



struct AnalyticsView: View {
    
    var body: some View {
        HStack (spacing: 0) {
            ScrollView{
                VStack {
                    ZStack {
                        ProfitGraphView()
                            .frame(maxWidth: 800)
                            .padding(.leading, 100)
                        
                        Text("Profit")
                            .fontWeight(.bold)
                            .font(.system(size: 40))
                            .offset(x: -340, y: -140)
                        
                        
                        VStack {
                            Text("$3000\n")
                            Text("$2000\n")
                            Text("$1000")
                        }.font(.system(size: 25))
                            .offset(x: -385)
                        
                        HStack {
                            Text("Mon")
                            Text("    Tue")
                            Text("    Wed")
                            Text("    Thu")
                            Text("     Fri")
                            Text("        Sat")
                            Text("     Sun")
                            Text("     Mon")
                            Text("     Tue")
                            Group {
                                Text("     Wed")
                                Text("    Thu")
                            }
                        }.font(.system(size: 25))
                            .offset(x: 44, y: 130)
                    }
                    
                    ZStack {
                        CustomerGraphView()
                            .frame(maxWidth: 800)
                            .padding(.leading, 100)
                        
                        Text("Customers")
                            .fontWeight(.bold)
                            .font(.system(size: 40))
                            .offset(x: -300, y: -140)
                        
                        
                        VStack {
                            Text("60\n")
                            Text("40\n")
                            Text("20")
                        }.font(.system(size: 25))
                            .offset(x: -365)
                        
                        HStack {
                            Text("Mon")
                            Text("    Tue")
                            Text("    Wed")
                            Text("    Thu")
                            Text("     Fri")
                            Text("        Sat")
                            Text("     Sun")
                            Text("     Mon")
                            Text("     Tue")
                            Group {
                                Text("     Wed")
                                Text("    Thu")
                            }
                        }.font(.system(size: 25))
                            .offset(x: 44, y: 130)
                    }.offset(y: 100)
                    
                    ZStack {
                        OrdersGraphView()
                            .frame(maxWidth: 800)
                            .padding(.leading, 100)
                        
                        Text("Menu Orders")
                            .fontWeight(.bold)
                            .font(.system(size: 40))
                            .offset(x: -280, y: -140)
                        
                        
                        VStack {
                            Text("150\n")
                            Text("100\n")
                            Text("50")
                        }.font(.system(size: 25))
                            .offset(x: -365)
                        
                        HStack {
                            Text("Mon")
                            Text("    Tue")
                            Text("    Wed")
                            Text("    Thu")
                            Text("    Fri")
                            Text("    Sat")
                            Text("    Sun")
                            Text("    Mon")
                            Text("    Tue")
                            Group {
                                Text("     Wed")
                                Text("    Thu")
                            }
                        }.font(.system(size: 25))
                            .offset(x: 44, y: 130)
                    }.offset(y: 200)
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            VStack {
                Text("Analytics")
                    .font(Font.custom("DIN Bold", size: 60))
                    .padding(.top, 10)
                
                Text("Menu Item By Popularity")
                    .fontWeight(.bold)
                    .offset(x: -30)
                    .padding(.top, 10)
                
                List {
                    Text("1.  Rib Eye")
                    Text("2.  Chicken Schnitzel")
                    Text("3.  Sirloin Steak")
                    Text("4.  Porterhouse")
                    Text("5.  Spaghetti Carbonara")
                    Text("6.  New York Strip")
                    Text("7.  Chicken Penne Pasta")
                    Text("8.  Caesar Salad")
                    Text("9.  Mac N Cheese")
                    Text("10. Garlic Mashed Potato")
                }
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .cornerRadius(30)
                        .foregroundColor(Color.blue)
                        .frame(width: 380, height: 100)
                        .padding(.bottom, 10)
                    
                    Text("Export")
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

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
