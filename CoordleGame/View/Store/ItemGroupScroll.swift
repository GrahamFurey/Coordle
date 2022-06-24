//
//  ItemGroupScroll.swift
//  CoordleGame
//
//  Created by Graham Furey on 5/4/22.
//

import SwiftUI

struct ItemGroupScroll: View {
    
    @State var level = 0
    @State var selected = 2
    @State var isMoving = false
    @Binding var unlocks: [Int]
    @Binding var current: Int
    var items: [Item]
    
    let w = Global.screenWidth * 0.9
    let h = Global.screenHeight * 0.12
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 5) {
            
            SegLevelControl(selected: $level)
        
            ItemScroll(level: $level, selected: $selected,
                       isMoving: $isMoving, items: items, h: h)
                .frame(width: w, height: h*1.5)
                .overlay(
                    ZStack(alignment: .bottom) {
                        let u = items[selected].unlocked
                        SelectionOutline(w: h*1.1, h: h)

                        Button(action: { withAnimation(.spring()) { current = selected}}) {
                            ItemSelectionButton(unlocked: u, isSet: current == selected, isMoving: isMoving, h: h*0.8)
                        }
                        .padding(.bottom,3)
                        .buttonStyle(AdvancedButtonStyle())
                        .disabled(!items[selected].unlocked || isMoving)
                    }
                )
        }
    }
    
    func getRanks()->[Item] {
        var noChange = items
        for i in unlocks {
            if i < noChange.count {
                noChange[i].unlocked = true
            }
        }
        
        return noChange
    }
}

struct ItemGroupScroll_Previews: PreviewProvider {
    static var previews: some View {
        ItemGroupScroll(unlocks: .constant([0,3,5,9]), current: .constant(0), items: pfpItems)
    }
}


struct SegLevelControl: View {
    @Binding var selected: Int
    @Namespace var animation
    let ani = Animation.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)
    var body: some View {
        
        HStack(spacing: 0) {
            
            Button(action: { withAnimation(ani){ selected = 0 } }) {
                Text("Common")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.vertical,8)
                    .padding(.horizontal,10)
                    .background(
                        ZStack {
                            if selected == 0 {
                                Color.white
                                    .colorMultiply(Color.giftGreen1.opacity(0.8))
                                    .clipShape(Capsule())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
            }
            .foregroundColor(selected == 0 ? .white : .gray)
            
            Button(action: { withAnimation(ani){ selected = 1 } }) {
                Text("Rare")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.vertical,6)
                    .padding(.horizontal,10)
                    .background(
                        ZStack {
                            if selected == 1 {
                                Color.white
                                    .colorMultiply(Color.giftBlue1.opacity(0.8))
                                    .clipShape(Capsule())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
            }
            .foregroundColor(selected == 1 ? .white : .gray)
            
            Button(action: { withAnimation(ani){ selected = 2 } }) {
                Text("Epic")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.vertical,6)
                    .padding(.horizontal,10)
                    .background(
                        ZStack {
                            if selected == 2 {
                                Color.white
                                    .colorMultiply(Color.giftPurp1.opacity(0.8))
                                    .clipShape(Capsule())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
            }
            .foregroundColor(selected == 2 ? .white : .gray)
            
            Button(action: { withAnimation(ani){ selected = 3 } }) {
                Text("Legendary")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.vertical,6)
                    .padding(.horizontal,10)
                    .background(
                        ZStack {
                            if selected == 3 {
                                Color.white
                                    .colorMultiply(Color.giftYellow1.opacity(1.0))
                                    .clipShape(Capsule())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
            }
            .foregroundColor(selected == 3 ? .white : .gray)
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 5)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.darkShadow,Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Capsule()
                    .stroke(Color.darkShadow,lineWidth: 5)
                    .opacity(0.8)
            }
        )
        .clipShape(Capsule())
        
    }
}

struct ItemSelectionButton: View {
    
    var unlocked: Bool
    var isSet: Bool
    var isMoving: Bool
    var h: CGFloat
    
    var body: some View {
        ZStack {
            LockButton(width: h*0.5)
            
            UseButton(text: "SET", color1: .lighterBlue,
                      color2: .lightBlue, width: h)
                .opacity(unlocked ? 1.0 : 0.0)
            
            UseButton(text: "USE", color1: .giftGreen1,
                      color2: .giftGreen2, width: h)
                .opacity(unlocked ? 1.0 : 0.0)
        }
        .grayscale(isMoving ? 0.7 : 1.0)
    }
}


