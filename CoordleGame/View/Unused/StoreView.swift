////
////  StoreView.swift
////  CoordleGame
////
////  Created by Graham Furey on 4/3/22.
////
//
//import SwiftUI
//
//struct ScrollHorizontal: View {
//    
////    @Binding var presentAd: Bool
//    @State var backgroundOffset: CGFloat = 0
//    @EnvironmentObject var player: PlayerModel
//    
//    var body: some View {
//        
//        ZStack(alignment: .top) {
//        
//        GeometryReader { geo in
//                
//            HStack(spacing: 0) {
//                    
//                    Rectangle()
//                        .fill(Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)))
//                        .frame(width: geo.size.width, height: geo.size.height)
//                    
//                ShopView(x: geo.size.width / 2, y: geo.size.height / 2.05)
//                        .frame(width: geo.size.width, height: geo.size.height)
//                    
//                    Rectangle()
//                        .fill(Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)))
//                        .frame(width: geo.size.width, height: geo.size.height)
//                    
//                    Rectangle()
//                        .fill(Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)))
//                        .frame(width: geo.size.width, height: geo.size.height)
//                
//                    Rectangle()
//                        .fill(Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)))
//                        .frame(width: geo.size.width, height: geo.size.height)
//                    
//                    
//                }.offset(x: -((self.backgroundOffset + 1) * geo.size.width))
//                .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6))
//                
//                    HStack {
//                        
//                        Button(action: {
//                            
//                            self.backgroundOffset = 0
//                            
//                        }) {
//                        
//                            Image("gemBorderBlack")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: self.backgroundOffset == 0 ? 40 : 20)
//                                .opacity(self.backgroundOffset == 0 ? 1 : 0.5)
//                            
//                        }
//                        
//                        Button(action: {
//                            
//                            self.backgroundOffset = 1
//                            
//                        }) {
//                        
//                            Image("textBorderBlack")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: self.backgroundOffset == 1 ? 40 : 20)
//                                .opacity(self.backgroundOffset == 1 ? 1 : 0.5)
//                            
//                        }
//                        
//                        Button(action: {
//                            
//                            self.backgroundOffset = 2
//                            
//                        }) {
//                        
//                            Image("keyBorderBlack")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: self.backgroundOffset == 2 ? 40 : 20)
//                                .opacity(self.backgroundOffset == 2 ? 1 : 0.5)
//                            
//                        }
//                    }
//                    .padding()
//                    .background(
//                    
//                        Rectangle()
//                            .fill(Color.white.opacity(0.3))
//                            .cornerRadius(10)
//                        
//                    )
//                    .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6))
//                    .position(x: geo.size.width / 2, y: geo.size.height / 1.2)
//                
//            }.gesture (
//                DragGesture()
//                    .onEnded({ val in
//                        
//                        if val.translation.width > 10 {
//                            
//                            if self.backgroundOffset > 0 {
//                                self.backgroundOffset -= 1
//                            }
//                        
//                        } else if val.translation.width < -10 {
//                            
//                            if self.backgroundOffset < 3 {
//                                self.backgroundOffset += 1
//                            }
//                        }
//                    })
//            )
//            
//                HStack {
//                    
//                    Text("")
//                    
//                    Spacer()
//                    
//                    GemTicker(amount: player.jewels, plus: false)
//                    
//                }.offset(x: 5)
//        
//        }
//    }
//}
//
