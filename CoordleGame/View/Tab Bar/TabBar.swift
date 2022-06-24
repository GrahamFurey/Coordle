////
////  TabBar.swift
////  Coordle
////
////  Created by Graham Furey on 3/26/22.
////
//
//import SwiftUI
//
//struct TabBar: View {
//    
//    @Binding var selectedTab: String
//    @State var tabPoints : [CGFloat] = []
//    
//    @Binding var offset: Bool
//    
//    var body: some View {
//        
//        HStack(spacing: 0) {
//            
//            TabBarButton(image: "play", selectedTab: $selectedTab, tabPoints: $tabPoints)
//            TabBarButton(image: "cart", selectedTab: $selectedTab, tabPoints: $tabPoints)
//            TabBarButton(image: "chart", selectedTab: $selectedTab, tabPoints: $tabPoints)
//            TabBarButton(image: "gear", selectedTab: $selectedTab, tabPoints: $tabPoints)
//            
//        }.padding()
//        .background(
//            Color.white
//                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
//        )
//        .overlay(
//        
//            Circle()
//                .fill(Color.white)
//                .frame(width: 10, height: 10)
//                .offset(x: getCurvePoint() - 20)
//            
//            ,alignment: .bottomLeading
//            
//        )
//        .cornerRadius(20)
//        .padding(.horizontal, 20)
//        .offset(y: offset ? 250 : 0)
//        .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
////        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
//    }
//    
//    func getCurvePoint()->CGFloat {
//        if tabPoints.isEmpty {
//            return 10
//        } else {
//            switch selectedTab {
//            case "play":
//                return tabPoints[0]
//            case "cart":
//                return tabPoints[1]
//            case "chart":
//                return tabPoints[2]
//            case "gear":
//                return tabPoints[3]
//            default:
//                return tabPoints[0]
//            }
//        }
//    }
//}
//
//struct TabBarButton: View {
//    
//    var image: String
//    @Binding var selectedTab: String
//    @Binding var tabPoints : [CGFloat]
//    
//    var body: some View {
//        GeometryReader{ reader -> AnyView in
//            
//            let midX = reader.frame(in: .global).midX
//            
//            DispatchQueue.main.async {
//                if tabPoints.count <= 4 {
//                    tabPoints.append(midX)
//                }
//            }
//            
//            return AnyView(
//            
//            Button(action: {
//                
//                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
//                    selectedTab = image
//                }
//                
//            }) {
//                
//                    Image(selectedTab == image ? "\(image).fill" : image)
//                    .renderingMode(.template)
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(.black)
//                    .frame(height: 30)
//                    .offset(y: selectedTab == image ? -10 : 0)
//                
//                
//                }.frame(maxWidth: .infinity, maxHeight: .infinity)
//            )
//        }.frame(height: 40)
//    }
//}
//
//struct gg2: PreviewProvider {
//    static var previews: some View {
//        TabBar(selectedTab: .constant("cart"), offset: .constant(false))
//    }
//}
