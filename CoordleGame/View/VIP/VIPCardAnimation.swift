//
//  VIPCardAnimation.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/11/22.
//

import SwiftUI

struct VIPCardAnimation: View {
    var body: some View {
        
        Image("ticket")
            .resizable()
            .scaledToFit()
            .padding()
            .frame(height: 250)
            .shadow(color: .black.opacity(0.7), radius: 3, x: 3, y: 3)
            .overlay(

                Group {
                    
                    spawnCapsule(offsetY: Global.screenHeight * 0.8)
                        .animation(Animation.linear(duration: 0.6).delay(0.2).repeatForever(autoreverses: false))
                    
                    spawnCapsule(offsetY: Global.screenHeight * 0.04)
                        .animation(Animation.linear(duration: 0.6).delay(0.7).repeatForever(autoreverses: false))
                    
                    spawnCapsule(offsetY: -(Global.screenHeight * 0.04))
                        .animation(Animation.linear(duration: 0.6).delay(1.4).repeatForever(autoreverses: false))
                    
                    spawnCapsule(offsetY: -(Global.screenHeight * 0.8))
                        .animation(Animation.linear(duration: 0.6).delay(1.8).repeatForever(autoreverses: false))
                    
                    spawnSparkle()
                        .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false))
                    
                    spawnSparkle()
                        .animation(Animation.linear(duration: 0.6).delay(0.7).repeatForever(autoreverses: false))
                
                    spawnSparkle()
                        .animation(Animation.linear(duration: 0.6).delay(0.9).repeatForever(autoreverses: false))
                    
                    spawnSparkle()
                        .animation(Animation.linear(duration: 0.6).delay(1.5).repeatForever(autoreverses: false))
                    
                    spawnSparkle()
                        .animation(Animation.linear(duration: 0.6).delay(2.0).repeatForever(autoreverses: false))

                }
            )
    }
}

struct spawnSparkle: View {
    
    @State var spawn = false
    @State var despawn = false
    @State var deSpawnLocation: CGFloat = -150
    @State var deSpawnSize: CGFloat = 0.5
    
    let offsetY: CGFloat = CGFloat.random(in: -(Global.screenHeight * 0.1)...(Global.screenHeight * 0.1))
    
    let spawnLocation: CGFloat = Global.screenWidth * 0.7
    let mid: CGFloat = Global.screenWidth * 0.5
    let tenthWidth = Global.screenWidth * 0.2
    
    var body: some View {
        
        Image(systemName: "sparkle")
            .font(.system(size: 55, weight: .bold))
            .foregroundColor(.white)
            .opacity(despawn ? 0.5 : (spawn ? 1 : 0.7))
            .shadow(color: .white.opacity(0.7), radius: 3, x: 3, y: 3)
            .scaleEffect(despawn ? deSpawnSize : 1.0)
            .offset(x: despawn ? deSpawnLocation : (spawn ? mid : spawnLocation))
            .offset(y: offsetY)
        
            .onAppear {
                
                    mainAnimation()
            }
        
    }
    
    func mainAnimation() {
        let random = CGFloat.random(in: -tenthWidth...0)
        deSpawnLocation = -(Global.screenWidth / 2) + random
        deSpawnSize = Double.random(in: 0.5...0.9)
        
        withAnimation(Animation.linear) {
            spawn = true
        }
        
        withAnimation(Animation.linear.delay(0.2)) {
            despawn = true
        }
    }
    
}


struct spawnCapsule: View {
    
    @State var spawn = false
    @State var despawn = false
    @State var deSpawnLocation: CGFloat = -150
    @State var deSpawnSize: CGFloat = 0.5
    
    var offsetY: CGFloat
    
    let spawnLocation: CGFloat = Global.screenWidth * 0.7
    let mid: CGFloat = Global.screenWidth * 0.5
    let tenthWidth = Global.screenWidth * 0.2
    
    var body: some View {
         
        Capsule()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0)]), startPoint: .trailing, endPoint: .leading))
            .frame(width: mid, height: Global.screenHeight / 40)
            .opacity(despawn ? 0.5 : (spawn ? 1 : 0.7))
            .offset(x: despawn ? deSpawnLocation : (spawn ? mid : spawnLocation))
            .offset(y: offsetY)
        
            .onAppear {
                
                    mainAnimation()
            }
        
    }
    
    func mainAnimation() {
        let random = CGFloat.random(in: -tenthWidth...0)
        deSpawnLocation = -(Global.screenWidth / 2) + random
        deSpawnSize = Double.random(in: 0.5...0.9)
        
        withAnimation(Animation.linear) {
            spawn = true
        }
        
        withAnimation(Animation.linear.delay(0.2)) {
            despawn = true
        }
    }
    
}

struct VIPCardAnimation_Previews: PreviewProvider {
    static var previews: some View {
        VIPCardAnimation()
    }
}
