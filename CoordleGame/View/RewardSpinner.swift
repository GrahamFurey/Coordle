//
//  RewardSpinner.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/26/22.
//

import SwiftUI

struct RewardSpinner: View {
    
    @StateObject var system = SystemFunctions()
    @State var spin = false
    @State var degrees = 0.0
    @State var reveal = false
    @State var index = 0
    
    var body: some View { 
        VStack {
            VStack(spacing: 30) {
                
                RarityView(degrees: degrees, spin: spin, index: index)
                
                ZStack {
                    
                    HStack(spacing: 10) {
                        
                        Text("CLAIM")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.white.opacity(0.7))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.gray)))
                    
                        Button(action: { spinBox() }) {
                            FlashingButton(ad: true, title: "AGAIN")
                        }
                        .buttonStyle(AdvancedButtonStyle())
                        
                    }
                    .offset(x: reveal ? 0 : Global.screenWidth)
                
                    Button(action: { spinBox() }) {
                        FlashingButton(spin: spin)
                    }
                    .buttonStyle(AdvancedButtonStyle())
                    .disabled(spin)
                    
                    .offset(x: reveal ? -(Global.screenWidth) : 0)
                    
                }
            }
            .frame(width: Global.screenWidth * 0.8, height: Global.screenHeight * 0.45)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3))
        .edgesIgnoringSafeArea(.all)
    }
    
    func spinBox() {
        spin.toggle()
        
        let p : [Double] = [2160, 2205, 2250, 2295]
        let r = Int.random(in: 0...3)
        //MAKE SURE THIS MATCHES FINAL PROBABILITY
        let f = p[r] * 2
        
        withAnimation(Animation.timingCurve(0.37, 0.01, 0.22, 1.07, duration: 7)) {
            degrees -= f
        }
        
        system.playSound("\(Int(p[r]))", 0.5)
        system.playSpinHaptics(r)
        setColors(r)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            withAnimation(Animation.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                reveal.toggle()
            }
        }
    }
    
    func setColors(_ id: Int) {
        let times = Global.spinHaptics[id]
        
        for i in times {
            let time = DispatchTimeInterval.milliseconds(i)
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                withAnimation(Animation.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.3)) {
                    
                    if index == 3 {
                        index = 0
                    } else {
                        index += 1
                    }
                    
                }
            }
        }
    }
}

struct RarityView: View {
    
    var degrees: Double
    var spin: Bool
    var index: Int
    
    let rarities = ["COMMON","RARE","EPIC","LEGENDARY"]
    let imgs = ["giftCommon","giftRare","giftEpic","giftLegendary"]
    let textColors = [Color.giftGreen1,.giftBlue1,.giftPurp1,.giftYellow1]
    let bgColors = [Color.giftGreen2,.giftBlue2,.giftPurp2,.giftYellow2]
    
    var body: some View {
        VStack(spacing: 5) {
            
            ZStack {
                ForEach(0..<4, id: \.self) { i in
                    RaritySelection(title: rarities[i],
                                    fg: textColors[i],
                                    bg: bgColors[i])
                        .rotation3DEffect(.degrees(degrees + Double(90*i)),
                                          axis: (1,0,0),
                                          anchor: .bottom,
                                          anchorZ: 0, perspective: 2.0)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .opacity(spin ? 1 : 0)
                
                RainbowRarity()
                    .opacity(spin ? 0 : 1)
            }
            
            ZStack {
                
                RainbowGift(spun: spin)
                    .opacity(spin ? 0 : 1)
                
                ForEach(0..<4, id: \.self) { i in
                    GiftView(img: imgs[i], bg: bgColors[i])
                        .opacity(index == i ? 1 : 0)
                }
                .opacity(spin ? 1 : 0)
            }
            
            
        }
    }
}

struct RainbowRarity: View {
    @State var hueRotate = false
    @State var move = false
    
    var body: some View {
        
        HStack {
            
            arrow()
                .offset(x: move ? -10 : 0)
        
            Text("???")
                .foregroundColor(Color.white.opacity(0.5))
                .font(.system(size: 30, weight: .bold))
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.giftBlue2)
                        .hueRotation(.degrees(hueRotate ? -300 : .pi * 200))
                        .opacity(0.6)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.1), lineWidth: 10)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 7).repeatForever(autoreverses: false)) {
                        self.hueRotate.toggle()
                    }
                    
                    withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
                        self.move.toggle()
                    }
                }
            
            arrow(true)
                .offset(x: move ? 10 : 0)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func arrow(_ left: Bool = false)->some View {
        Image(systemName: "chevron.\(left ? "left" : "right")")
            .font(.system(size: 35, weight: .heavy))
            .foregroundColor(Color(UIColor.lightGray))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.gray))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.1), lineWidth: 10)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct RainbowGift: View {
    @State var hueRotate = false
    @State var bounce = 0.0
    var spun: Bool
    
    var body: some View {
        
        Image("giftRare")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .hueRotation(.degrees(hueRotate ? -300 : .pi * 200))
            .scaleEffect(0.7)
            .frame(maxWidth: .infinity)
            .overlay(
                Image("giftWrap")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(0.7)
            )
            .background(
                Image("giftCommon")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color.black.opacity(0.6))
                    .scaleEffect(0.7)
                    .offset(x: 7, y: 10)
            )
            .offset(y: bounce)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.giftBlue2.opacity(0.7))
                    .hueRotation(.degrees(hueRotate ? -300 : .pi * 200))
            )
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 7).repeatForever(autoreverses: false)) {
                    self.hueRotate.toggle()
                }
                
                jump()
                
            }
    }
    
    func jump(_ start: CGFloat = -30) {
        withAnimation(Animation.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0.7)) {
            bounce = start
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(Animation.interpolatingSpring(stiffness: 350, damping: 7, initialVelocity: 15)) {
                bounce = -7
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeIn(duration: 0.1)) {
                bounce = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if !spun {
                jump()
            }
        }
    }
}

struct GiftView: View {
    var img: String
    var bg: Color
    
    var body: some View {
        
        Image(img)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(0.7)
            .frame(maxWidth: .infinity)
            .overlay(
                Image("giftWrap")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(0.7)
            )
            .background(
                Image("giftCommon")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color.black.opacity(0.6))
                    .scaleEffect(0.7)
                    .offset(x: 7, y: 10)
            )
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .colorMultiply(bg.opacity(0.7))
            )
    }
}

struct RaritySelection: View {
    
    var title: String
    var fg: Color
    var bg: Color
    
    var body: some View {
        
        Text(title)
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(fg)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(bg)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.1), lineWidth: 10)
            )
            
    }
}

struct FlashingButton: View {
    @State var highlighted = Color.lightBlue
    
    var ad = false
    var spin: Bool = false
    var fg: Color = Color.white
    var title: String = "OPEN"
    var color2: Color = .blue
    
    var body: some View {
        
        HStack(spacing: 5) {
        
            Text(title)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(spin ? Color(UIColor.lightGray) : fg)
            
            if ad {
                Image(systemName: "play.rectangle.fill")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.white)
            }
        }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    if !spin {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .colorMultiply(self.highlighted)
                    } else {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(UIColor.gray))
                    }
                }
                .shadow(color: Color.black.opacity(0.6), radius: 2, x: 2, y: 3)
            )
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
                    highlighted = color2
                }
            }
    }
}

struct AdvancedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}

struct RewardSpinner_Previews: PreviewProvider {
    static var previews: some View {
        RewardSpinner()
    }
}
