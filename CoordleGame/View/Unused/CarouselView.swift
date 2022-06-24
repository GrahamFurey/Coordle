////
////  CarouselView.swift
////  CoordleGame
////
////  Created by Graham Furey on 4/25/22.
////
//
//import SwiftUI
//
//struct CarouselView: View {
//    
//    @State var currentIndex: Int = 0
//    @State var items: [Item] = []
//    
//    var body: some View {
//        VStack(spacing: 15) {
//           
//            VStack(alignment: .leading, spacing: 12) {
//                
//                Text("Choose your character")
//                    .font(.system(size: 25, weight: .bold))
//                    .foregroundColor(.textColor)
//                
//            }.frame(maxWidth: .infinity, alignment: .leading)
//            .padding()
//            
//            SnapCarousel(spacing: 10, index: $currentIndex, items: items) { item in
//                
//                    VStack(spacing: 10) {
//                    
//                    Image("\(item.img)Face")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .scaleEffect(0.65)
//                        .background(
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(item.color)
//                                Image("\(item.img)Face")
//                                    .renderingMode(.template)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .foregroundColor(.white)
//                                    .scaleEffect(0.72)
//                            }
//                        )
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .stroke(Color.black.opacity(0.1), lineWidth: 10)
//                                .background(Color.clear)
//                        )
//                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        
//                        RoundedRectangle(cornerRadius: 100)
//                            .fill(RadialGradient(colors: currentIndex == item.id ? [Color.gray, Color.background] : [Color.clear], center: .center, startRadius: 10, endRadius: 110))
//                            .rotation3DEffect(.degrees(80), axis: (x: 1, y: 0, z: 0))
//                            .offset(y: -50)
//                }
//            }
//            .padding(.vertical,0)
//            
//            HStack(spacing: 10) {
//                
//                ForEach(0..<5) { index in
//                    
//                    Circle()
//                        .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
//                        .frame(width: 10, height: 10)
//                        .animation(.spring(), value: currentIndex == index)
//                    
//                }
//                
//            }
//            .padding(.bottom, 10)
//            
//        }
//        .frame(maxHeight: .infinity, alignment: .top)
//        .background(Color.background)
//    }
//}
//
//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView()
//    }
//}
