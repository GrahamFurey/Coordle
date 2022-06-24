//
//  RewardPopUp.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/4/22.
//

import SwiftUI

struct RewardPopUp: View {
    
    @State var show = false
    @State var animation0 = false
    @State var animation1 = false
    @State var animation2 = false
    @State var animation3 = false
    @State var animation4 = false
    
    @EnvironmentObject var model: DataModel
    
    let yellow = Color(UIColor(red: 255/255, green: 218/255, blue: 0/255, alpha: 1.0))
    let orange = Color(UIColor(red: 253/255, green: 95/255, blue: 0/255, alpha: 1.0))
    
    let randoJewel: Int = [50,75,100][Int.random(in:0...2)]
    let randoUI: Int = [1,1,2,2,2,2,2,2,3,3,3,3][Int.random(in:0...11)]
    
    var body: some View {
        
        VStack(spacing: 15) {
        
        VStack(spacing: 10) {
            
            HStack {
                Text("")
                
                Spacer()
                
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(0.8)
            }
            
            Image(4 > 3 ? "highScore" : "win")
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .opacity(animation1 ? 1 : 0)
                .offset(y: animation1 ? 0 : 50)
            
            ZStack {
                
                let text = 4 > 3 ? "NEW HIGH SCORE" : "Congratulations!"
            
                Text(text)
                    .font(.system(size: 23))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white.opacity(0.25))
                    
                HStack(spacing: 0){
                    
                    ForEach(0..<text.count,id: \.self){index in
                        
                        Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                            .font(.system(size: 23))
                            .fontWeight(.semibold)
                            .foregroundColor(randomColor())
                    }
                }
                    
                    .mask(
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: .init(colors: [.clear, Color.white.opacity(0.95)]), startPoint: .top, endPoint: .bottom)
                            
                            )
                            .rotationEffect(.init(degrees: 20))
                            .offset(x: -250)
                            .offset(x: show ? 500 : 0)
                        
                    
                    )
                
            }
            .opacity(animation2 ? 1 : 0)
        
            HStack(spacing: 10) {
                
                HStack(spacing: 10) {
                    
                    Image("xp")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .scaleEffect(1.05)
                        )
                    
                    RollingNumberAnimation(total: 300, enteredNumber: 20)
                    
                }
                
                Spacer()
                
                HStack(spacing: 10) {
                    
                    Image("gem")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                    
                    RollingNumberAnimation(total: 300, enteredNumber: 100)
                    
                }
                
            }
            .padding(.horizontal, 20)
            .opacity(animation3 ? 1 : 0)
            .offset(y: animation3 ? 0 : 50)
            
        }
            
            HStack(spacing: 15) {
                
                VStack(spacing: 5) {
                    
                    Text("Get 2X with a video")
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                
                        CollectButton(jewels: 320*2, points: 400*2)
                        
                    
                    
                }.frame(maxWidth: .infinity)
                
                VStack(spacing: 5) {
                    
                    HStack(spacing: 0) {
                    
                        Text("Get 3X with ")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                        
                        Image("gem")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                        
                        Text(" \(randoJewel)")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                        
                    }
                
                    
                            CollectButton(jewels: 320*, points: 400*2)
                        
                    
                    
                }.frame(maxWidth: .infinity)
                
            }.frame(maxWidth: .infinity)
            .opacity(animation4 ? 1 : 0)
            .offset(y: animation4 ? 0 : 50)
            
        }.padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.9))
        )
        .padding(.horizontal, 40)
        .offset(y: animation0 ? 0 : 1000)
        .onAppear {
            
            withAnimation(Animation.interactiveSpring(response: 1.0, dampingFraction: 0.9, blendDuration: 1.0)) {
                animation0.toggle()
            }
            
            withAnimation(Animation.interactiveSpring(response: 1.1, dampingFraction: 0.9, blendDuration: 1.0).delay(0.7)) {
                animation1.toggle()
            }
            
            withAnimation(Animation.easeOut(duration: 0.5).delay(1.3)) {
                animation2.toggle()
                
                withAnimation(Animation.default.speed(0.15).delay(0.4)
                                .repeatForever(autoreverses: false)) {
                    
                    self.show.toggle()
                    
                }
            }
            
            withAnimation(Animation.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6).delay(1.6)) {
                animation3.toggle()
            }
            
            withAnimation(Animation.easeOut(duration: 0.5).delay(2.1)) {
                animation4.toggle()
            }
            
        }
    }
    
    func randomColor()->Color{
        
        let color = UIColor(red: 1, green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        return Color(color)
    }
}

struct CollectButton: View {
    
    @State var scale: CGFloat = 1
    
    var jewels: Int
    var points: Int
    
    let topColor = Color(UIColor(red: 247/255, green: 214/255, blue: 81/255, alpha: 1.0))
    let bottomColor = Color(UIColor(red: 240/255, green: 202/255, blue: 69/255, alpha: 1.0))
    
    var body: some View {
        
        VStack(spacing: 3) {
            
            Text("Collect")
                .font(.system(size: 16))
                .foregroundColor(.textColor)
            
            VStack(alignment: .leading, spacing: 4) {
            
                HStack(spacing: 5) {
                    
                    Image("xp")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                    
                    Text("+\(String(points))")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.textColor)
                    
                }.offset(x: -3)
                
                HStack(spacing: 8) {
                    Image("gem")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                    
                    Text("+\(String(jewels*2))")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.textColor)
                    
                }
                
            }
            
        }.padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        gradient: Gradient(stops: [Gradient.Stop(color: topColor, location: 0.0),
                                                   Gradient.Stop(color: topColor, location: 0.3),
                                                   Gradient.Stop(color: bottomColor, location: 0.3),
                                                   Gradient.Stop(color: bottomColor, location: 1.0)]),
                        startPoint: .top,
                        endPoint: .bottom)
                
                )
        
        )
        .scaleEffect(scale)
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.2)) {
                scale = 0.8
            }
            
            withAnimation(Animation.linear(duration: 0.2).delay(0.1)) {
                scale = 1.0
            }
        }
        
    }
}

//struct RewardPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        RewardPopUp(jewels: 250, points: 50, newHS: true)
//    }
//}
