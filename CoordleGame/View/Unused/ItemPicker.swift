////
////  ItemPicker.swift
////  CoordleGame
////
////  Created by Graham Furey on 4/26/22.
////
//
//import SwiftUI
//
//struct ItemPicker: View {
//    
//    @State var items: [Item] = []
//    @State var scrolled = 0
//    
//    let h = Global.screenHeight * 0.2
//    let w = Global.screenWidth - 200
//    
//    var body: some View {
//        HStack {
//            
//            ForEach(items.reversed()) { item in
//                
//                let subtract = CGFloat(item.id - scrolled)
//                
//                HStack {
//                    
//                    PFPView(img: item.img, color: item.color)
//                        .frame(height: item.id >= scrolled + 1 ? h - subtract*(h/5) : h)
//                        .offset(x: subtract <= 2 ? subtract * 25 : 60)
//                }
//                .offset(x: item.offset + h*0.6)
//            }
//        }
//        .gesture(DragGesture()
//            .onChanged({ val in
//                if scrolled == item.id {
//                    let wd = val.translation.width
//                    
//                    withAnimation {
//                        if wd < 0 && item.id != items.last!.id {
//                            items[item.id].offset = wd
//                        } else {
//                            if item.id > 0 {
//                                items[item.id - 1].offset = -(w + 60) + wd
//                            }
//                        }
//                    }
//                }
//            }).onEnded({ val in
//                
//                let wd = val.translation.width
//                
//                withAnimation {
//                    
//                    if wd < 0 {
//                        
//                        if -wd > 180 && item.id != items.last!.id {
//                            items[item.id].offset = -(w*0.7)
//                            scrolled += 1
//                            
//                        } else {
//                            items[item.id].offset = 0
//                        }
//                        
//                    } else {
//                        if item.id > 0 {
//                            if wd > 180 {
//                                items[item.id - 1].offset = 0
//                                scrolled -= 1
//                            } else {
//                                items[item.id - 1].offset = -(w*0.7)
//                            }
//                        }
//                        
//                    })
//                )
//                
//            
//            }
//        }
//        .frame(height: h)
//        .onAppear {
//            items = storeItems
//        }
//    }
//}
//
//struct ItemPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemPicker()
//    }
//}
