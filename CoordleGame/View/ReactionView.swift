//
//  ReactionView.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/29/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReactionToggle: View {
    @State var shown = false
    var emotes: [Emote]
    var body: some View {
        HStack(spacing: 10) {
            Button(action: {
                withAnimation(.easeOut(duration: 0.7)) {
                    shown.toggle()
                }
            }) {
                Image("Characters")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .colorMultiply(shown ? .lightBlue : .textColor)
                    .rotationEffect(shown ? .degrees(-180) : .zero)
                    .frame(width: 35, height:  35)
                    .padding(.vertical,7)
                    .padding(.horizontal,10)
                    .background(Color.second)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: 5)

            }
            .buttonStyle(AdvancedButtonStyle())
            
            ReactView(shown: shown, emotes: emotes)
            
        }
    }
}


struct ReactView: View {
    
    @State var current: String = ""
    
    var shown: Bool
    var w = Global.screenWidth * 0.7
    let animation = Animation.linear(duration: 0.15)
    var vertPadding: CGFloat = 20
    var emotes: [Emote]
    
    var body: some View {
        
        HStack(spacing: 5) {
            
            ForEach(emotes, id: \.self) { gif in
                let n = gif.name
                EmoteCell(emote: gif)
                    .frame(width: current == n ? 100 : 40,
                           height: current == n ? 100 : 40)
                    .padding(current == n ? -30 : 0)
                    .offset(y: current == n ? -50 : 0)
            
            }
        }
        .padding(.vertical,7)
        .padding(.horizontal,15)
        .background(
            Color.white
            .offset(x: shown ? 0 : -400)
            .clipShape(Capsule()))
        .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: 5)
        .opacity(shown ? 1 : 0)
        .padding(.vertical, vertPadding)
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged(onChanged(_:))
            .onEnded(onEnded(_:)))
        .onChange(of: shown) { val in
            if val {
                callOffsets()
            }
        }
    }
    
    func callOffsets() {
        var delay = 0
        let reverse = [5,4,3,2,1,0]
        
        for i in 0...6 {
            let d = DispatchTimeInterval.milliseconds(delay)
            DispatchQueue.main.asyncAfter(deadline: .now() + d) {
                withAnimation(Animation.spring()) {
                    if i == 6 {
                        self.current = ""
                    } else {
                        let index = shown ? i : reverse[i]
                        self.current = emotes[index].name
                    }
                }
            }
            
            delay += shown ? 150 : 70
        }
    }
    
    func getOpacityAnimation(_ gif: String)->Double {
        
        var delay = 0.0
        switch gif {
        case emotes[0].name:
            delay = 0.03
        case emotes[1].name:
            delay = 0.0
        case emotes[2].name:
            delay = 0.03
        case emotes[3].name:
            delay = 0.06
        case emotes[4].name:
            delay = 0.09
        case emotes[5].name:
            delay = 0.12
        default:
            delay = 0.0
        }
        
        return delay
    }
    
    func onChanged(_ val: DragGesture.Value) {
        let x = val.location.x
        
        withAnimation(animation) {
            if x > 0 && x < 60{current = emotes[0].name}
            if x > 60 && x < 100{current = emotes[1].name}
            if x > 100 && x < 140{current = emotes[2].name}
            if x > 140 && x < 180{current = emotes[3].name}
            if x > 180 && x < 220{current = emotes[4].name}
            if x > 220 && x < 3600{current = emotes[5].name}
            
            if x < 20 || x > 360{current = ""}
        }
    }
    
    func onEnded(_ val: DragGesture.Value) {
        withAnimation(animation) {
            current = ""
        }
    }
}

struct EmoteCell: View {
    
    var emote: Emote
    var rate = 1.0
    
    var body: some View {
        
        AnimatedImage(name: emote.name + ".gif")
            .playbackRate(rate)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(
                ZStack {
                    if emote.scale != 0.0 {
                        Circle()
                            .fill(Color.white)
                            .scaleEffect(emote.scale)
                            .offset(y: emote.offsetBG)
                    }
                }
            )
        
    }
}
