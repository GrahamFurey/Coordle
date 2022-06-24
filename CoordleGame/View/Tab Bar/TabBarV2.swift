////
////  TabBarV2.swift
////  CoordleGame
////
////  Created by Graham Furey on 4/13/22.
////
//
//import SwiftUI
//
//struct TabBarV2: View {
//    
//    @Binding var selectedTab : String
//    @Namespace var animation
//    
//    var body: some View{
//
//        HStack(spacing: 0) {
//            
//            Spacer()
//            TabButtonV2(title: "Play", img: "play", selectedTab: $selectedTab, animation: animation)
//            Spacer()
//            TabButtonV2(title: "Shop", img: "cart", selectedTab: $selectedTab, animation: animation)
//            Spacer()
//            TabButtonV2(title: "Rank", img: "chart", selectedTab: $selectedTab, animation: animation)
//            Spacer()
//            TabButtonV2(title: "Settings", img: "gear", selectedTab: $selectedTab, animation: animation)
//            Spacer()
//            
//        }
//        .padding(.bottom, 20)
//        .background(Color.black)
//        
//    }
//}
//
//struct TabButtonV2: View {
//    var title : String
//    var img: String
//    @Binding var selectedTab : String
//    var animation : Namespace.ID
//    
//    var body: some View{
//        
//        Button(action: {
//        
//            withAnimation(Animation.interactiveSpring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.9)){
//                selectedTab = img
//            }
//            
//        }) {
//            
//            VStack(spacing: 4){
//                
//                Image(selectedTab == img ? "\(img).fill" : img)
//                    .renderingMode(.template)
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(selectedTab == img ? .red : .gray.opacity(0.7))
//                    .frame(height: 35)
//                    .scaleEffect(selectedTab == img ? 1.4 : 1.0)
//                    .rotationEffect(selectedTab == img ?  .init(degrees: -30) : .zero)
//                    .offset(y: selectedTab == img ? -10 : 0)
//                
//                Text(title)
//                    .font(.system(size: 12))
//                    .fontWeight(.semibold)
//                    .foregroundColor(selectedTab == img ? .red : .gray.opacity(0.7))
//                
//
//                    if selectedTab == img {
//                        
//                        CustomShape()
//                            .fill(Color.red)
//                            .frame(width: 55, height: 6)
//                            .matchedGeometryEffect(id: "Tab_Change", in: animation)
//                    }
//                
//            }
//        }
//    }
//}
//
//struct CustomShape: Shape {
//    
//    func path(in rect: CGRect) -> Path {
//        
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
//        
//        return Path(path.cgPath)
//    }
//}
//
//struct gg: PreviewProvider {
//    static var previews: some View {
//        TabBarV2(selectedTab: .constant("play"))
//    }
//}
