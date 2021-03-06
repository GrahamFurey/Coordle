////
////  Carousel.swift
////  CoordleGame
////
////  Created by Graham Furey on 4/25/22.
////
//
//import SwiftUI
//
//struct SnapCarousel<Content: View, T: Identifiable>: View {
//    
//    var content: (T)->Content
//    var list: [T]
//    
//    var spacing: CGFloat
//    var trailingSpace: CGFloat
//    @Binding var index: Int
//    
//    init(spacing: CGFloat = 0, trailingSpace: CGFloat = 0, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T)->Content) {
//        
//        self.list = items
//        self.spacing = spacing
//        self.trailingSpace = trailingSpace
//        self._index = index
//        self.content = content
//    }
//    
//    @GestureState var offset: CGFloat = 0
//    @State var currentIndex: Int = 0
//    
//    var body: some View {
//        
//        GeometryReader{proxy in
//            
//            let width = (Global.screenWidth * 0.3) - (trailingSpace - spacing)
//            let adjustmentWidth = (trailingSpace / 2) - spacing
//            
//            HStack(spacing: spacing) {
//                
//                ForEach(list) { item in
//                    
//                    content(item)
//                        .frame(width: (Global.screenWidth * 0.3) - trailingSpace)
//                }
//            }
//            .padding(.horizontal,spacing)
//            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustmentWidth : 0) * offset)
//            .gesture(
//                DragGesture()
//                    .updating($offset, body: { value, out, _ in
//                        out = value.translation.width
//                    })
//                    .onEnded({ value in
//                        let offsetX = value.translation.width
//                        let progress = -offsetX / width
//                        let roundIndex = progress.rounded()
//                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1),0)
//                        currentIndex = index
//                    })
//                    .onChanged({ value in
//                        let offsetX = value.translation.width
//                        let progress = -offsetX / width
//                        let roundIndex = progress.rounded()
//                        index = max(min(currentIndex + Int(roundIndex), list.count - 1),0)
//                    })
//            )
//            
//        }
//        .animation(.easeInOut, value: offset == 0)
//        
//    }
//}
