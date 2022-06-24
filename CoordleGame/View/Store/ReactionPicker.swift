//
//  ReactionPicker.swift
//  CoordleGame
//
//  Created by Graham Furey on 5/2/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReactionPicker: View {
    
    @StateObject var player: PlayerModel = PlayerModel()
    @State var showCollection = false
    
    var body: some View {
        
        VStack {
            
            VStack(spacing: 5) {
                
                StoreGroupTitle(title: "Emotes", current: 2, max: "37")
                
                StoreGroupInfo(caption: "Express yourself during multiplayer")
                
            }
            
            ReactView(shown: true, vertPadding: 10, emotes: allEmotes[0])
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Emote Collection")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.blackText.opacity(0.85))
                    
                    Text("Change loadout...")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.blackText.opacity(0.85))
                }
                
                Spacer()
                
                Button(action: {showCollection.toggle()}) {
                Image(systemName: "chevron.down")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white.opacity(0.9))
                    .rotationEffect(showCollection ? .degrees(180) : .zero)
                    .padding(.vertical,9)
                    .padding(.horizontal,5)
                    .background(Color.giftBlue1.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(AdvancedButtonStyle())
            }
            .padding(.vertical,5)
            .padding(.horizontal,7)
            .background(Color.darkShadow)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.clear)
                .frame(height: showCollection ? 180 : 0)
            
            CollectionView(beginAnimation: showCollection)
                .background(
                    ZStack {
                    Color.darkShadow
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: Global.screenWidth*0.85, height: showCollection ? 385 : 0)
                        .clipShape(RoundedRectangle(cornerRadius: 15))

                    LinearGradient(gradient: Gradient(colors: [Color.background,.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .frame(width: Global.screenWidth*0.825, height: showCollection ? 373 : 0)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .frame(height: showCollection ? 380 : 0)
                    .opacity(showCollection ? 1.0 : 0)
                    .offset(y: -10)
                    .animation(.easeInOut(duration: showCollection ? 0.7 : 0.4))
                    , alignment: .top
                )
                .frame(height: 0)
            

        }
        .frame(width: Global.screenWidth*0.85)
        
    }
}

struct GroupCellView: View {
    
    var beginAnimation: Bool
    var colors: [Color]
    var delay: Double
    
    var body: some View {
    
        ZStack {
        RoundedRectangle(cornerRadius: 7)
            .fill(LinearGradient(gradient: Gradient(colors: [colors[0],colors[1]]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .opacity(0.7)
            .padding(.vertical,4)
            .padding(.horizontal,4)
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(colors[1],lineWidth: 5)
                .opacity(0.8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(width: Global.screenWidth*0.8,height: 50)
        .opacity(beginAnimation ? 1 : 0)
        .rotation3DEffect(.degrees(beginAnimation ? 0 : 180), axis: (x: 1, y: 0, z: 0))
        .animation(Animation.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.6).delay(delay))
        
    }
}

struct CollectionView: View {
    
    var beginAnimation: Bool
    @State var current = ""
    
    var body: some View {
        VStack {
            ForEach(0..<7, id: \.self) { i in
                HStack {
                    let group = allEmotes[i]
                    ForEach(0..<group.count, id: \.self) { g in
                        let e = group[g]
                        EmoteCellJump(inView: beginAnimation, current: current, emote: e, delay: Double(e.index)*0.05)
                            .background(
                                ZStack {
                                    if current == e.name && beginAnimation {
                                        
                                        SelectionBox()
                                            .frame(width: 55, height: 60)
                                            .modifier(AddShadow(cr: 8, color: .darkShadow, offsetX: -2, offsetY: 3))
                                        UseButton(width: 50)
                                            .padding(.top,28)
                                    }
                                }
                                .padding(.bottom,25)
                            )
                            .onTapGesture {
                                current = e.name
                            }
                    }
                }
                .background(
                    GroupCellView(beginAnimation: beginAnimation, colors: getColors(i), delay:
                                    beginAnimation ? Double(i)*0.09 : Double(i)*0.05)
                )
                .padding(.vertical,2)
            }
        }
    }
    
    func getColors(_ i: Int)->[Color] {
        if i >= 0 && i <= 2 {
            return [.giftGreen1,.giftGreen2]
        }
        
        if i >= 3 && i <= 4{
            return [.giftBlue1,.giftBlue2]
            
        }
        if i == 5 {
            return [.giftPurp1,.giftPurp2]
            
        }
        if i == 6 {
            return [.giftYellow1,.giftYellow2]
            
        }
        return [.giftGreen1,.giftGreen2]
    }
    
}
//
//struct EmoteGroup: View {
//
//    @Binding var current: String
//    var group: [Emote]
//
//    var body: some View {
//        HStack {
//            ForEach(group, id: \.self) { g in
//                EmoteCellJump(current: $current, emote: g)
//                    .overlay(
//                        ZStack {
//                            if current == n {
//                                UseButton()
//                                    .offset(y: 10)
//                            }
//                        }
//                    )
//                    .onTapGesture {
//                        current = emote.name
//                    }
//            }
//        }
//    }
//
//    func playOnce(_ n: String, _ m: Int) {
//        runningRate = n
//        let time = DispatchTimeInterval.milliseconds(m)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
//            if runningRate == n {
//                runningRate = ""
//            }
//        }
//    }
//}

struct EmoteCellJump: View {
    
    var inView: Bool
    var current: String
    @State var firstPlay = false
    @State var jump = false
    @State var show = false
    var emote: Emote
    var delay: Double
    let animation = Animation.linear(duration: 0.15)
    
    var body: some View {
        EmoteCell(emote: emote, rate: (firstPlay || current == emote.name) ? 1.0 : 0.0)
            .frame(width: (jump || current == emote.name) ? 60 : 40,
                   height: (jump || current == emote.name) ? 60 : 40)
            .padding((jump || current == emote.name) ? -10 : 0)
            .offset(y: jump ? -30 : (current == emote.name ? -40 : 0))
            .opacity(show ? 1 : 0)
            .onChange(of: inView) { val in
                if val {
                    playOnce()
                    withAnimation(animation.delay(delay)) {
                        jump.toggle()
                        show.toggle()
                    }
                    
                    withAnimation(animation.delay(delay + 0.15)) {
                        jump.toggle()
                    }
                } else {
                    show.toggle()
                }
            }
    }
    
    func playOnce() {
        withAnimation(animation.delay(delay)) {
            firstPlay.toggle()
        }
        
        let d = Int(delay/1000)
        let end = DispatchTimeInterval.milliseconds(d + emote.duration)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + end) {
            firstPlay.toggle()
        }
    }
    
}


struct ReactionPicker_Previews: PreviewProvider {
    static var previews: some View {
        ReactionPicker()
    }
}
