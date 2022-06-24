////] cvb
////  ItemScroller.swift
////  CoordleGame
////
////  Created by Graham Furey on 4/28/22.
////
//
//import SwiftUI
//
//struct ItemScroller: View {
//    
//    @State var selection = 0
//    let tabs = ["Common","Rare","Epic","Legendary"]
//    let fgs = [Color.giftGreen2, .giftBlue2, .giftPurp2, .giftYellow2]
//    let bgs = [Color.giftGreen1,.giftBlue1,.giftPurp1,.giftYellow1]
//    
//    let w = Global.screenWidth * 0.9
//    let h = Global.screenHeight * 0.15
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            
//            let fg = fgs[selection]
//            let bg = bgs[selection]
//            
//            HStack(spacing: 0) {
//                ForEach(0..<4) { i in
//                    
//                    Button(action: {
//                        withAnimation {
//                        selection = i
//                        }
//                    }) {
//                    
//                    Text(tabs[i])
//                        .font(.system(size: 20, weight: .semibold))
//                        .foregroundColor(.white)
//                        .padding(7)
//                        .padding(.horizontal,2)
//                        .padding(.bottom,5)
//                        .background(fg)
//                        .cornerRadius(10, corners: [.topLeft,.topRight])
//                        .opacity(selection == i ? 1 : 0.5)
//                        .offset(y: 5)
//                    }
//                    .buttonStyle(AdvancedButtonStyle())
//                }
//            }
//            .fixedSize(horizontal: true, vertical: false)
//            
//            ItemScroll(h: h * 0.7, selection: $selection)
//                .padding(.vertical)
//                .padding(.top,5)
//                .frame(width: w, height: h*1.7)
//                .background(
//                    
//                    ZStack {
//                        Color.background
//
//                        LinearGradient(gradient: Gradient(colors: [bg.opacity(0.4),bg]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                    }
//                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 0)
//                        .stroke(LinearGradient(gradient: Gradient(colors: [fg,bg.opacity(0.7)]), startPoint: .top, endPoint: .bottomTrailing), lineWidth: 12)
//                        .background(RoundedRectangle(cornerRadius: 0)
//                            .stroke(Color.background, lineWidth: 12))
//                        .shadow(color: Color.white.opacity(0.8), radius: 4, x: 3, y: -1)
//                        .shadow(color: Color.white.opacity(0.8), radius: 4, x: -3, y: 0)
//                )
//                .cornerRadius(5, corners: [.bottomLeft,.bottomRight,.topRight])
//                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 5, y: 6)
//                .overlay(
//                    Button(action: {
//                        //
//                    }) {
//                        EquipOverlay(w: h, color1: fg, color2: bg)
//                            .offset(y: h*0.1)
//                    }
//                    .buttonStyle(AdvancedButtonStyle())
//                    , alignment: .bottom
//                )
//            
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.background)
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct ItemScroller_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemScroller()
//    }
//}
//
//struct EquipOverlay: View {
//    
//    var isUnlocked = true
//    var isEquipped = false
//    var w: CGFloat
//    var color1: Color
//    var color2: Color
//    
//    var body: some View {
//        ZStack {
//            
//            if isUnlocked {
//                
//                Text(isEquipped ? "EQUIPPED" : "EQUIP")
//                    .font(.system(size: 20, weight: .bold))
//                    .foregroundColor(.white)
//                    .padding(.vertical,5)
//                
//            } else {
//                Image(systemName: "lock.fill")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(.blackText)
//                    .padding(.vertical,5)
//            }
//        }
//        .frame(width: w)
//        .background(
//            
//            ZStack {
//                Capsule()
//                    .fill(LinearGradient(gradient: Gradient(colors: [color1,color2.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
//                
//                Capsule()
//                    .stroke(color1.opacity(0.8), lineWidth: 8)
//                
//            }
//                .background(Color.background)
//                .clipShape(Capsule())
//                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 6)
//        )
//    }
//}
