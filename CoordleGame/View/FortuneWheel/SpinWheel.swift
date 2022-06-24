//
//  SpinWheel.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/21/22.
//

import SwiftUI

struct FortuneWheel: View {
    
    @EnvironmentObject var system: SystemFunctions
    @EnvironmentObject var data: DataModel
    @Binding var disabled: Bool
    @State private var degree = 0.0
    @State private var setDirection = false
    @State private var clockwise = true
    @State private var isSpinning = false
    private let animation = Animation.timingCurve(0.37, 0.01, 0.22, 1.07, duration: 7)
    
    var inView: Bool
    
    let p = [2160, 2205, 2250, 2295, 2340, 2205, 2250, 2295]
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            VStack(spacing: 0) {
                
                VStack(spacing: 0) {
                    Text(disabled ? "More prizes in" : "Come back every 12")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.textColor)
                    
                    ZStack {
                        if disabled {
                            TimerTillTomorrow(disabled: $disabled, tomorrow: system.lastSpin, font: 30)
                                .foregroundColor(.textColor)
                        } else {
                            Text("hours to win prizes")
                                .font(.system(size: 30, weight: .semibold))
                                .foregroundColor(.textColor)
                        }
                    }
                }
                .padding(.top,10)
                .frame(height: Global.screenHeight*0.33)
                
                Spacer()
            }
            .padding()
            .padding(.horizontal)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .gold1, location: 0),Gradient.Stop(color: .gold2, location: 0.35)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
        
            VStack(spacing: 20) {
                
                Spacer()
                
                Text("FORTUNE WHEEL")
                    .font(.system(size: 30, weight: .heavy))
                    .foregroundColor(.white)
                    .padding(12)
                    .frame(width: Global.screenWidth * 0.8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [.gold1,.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: Color.black.opacity(0.6), radius: 3, x: 0, y: 2)
                    )
                    .padding(.vertical,20)
                
                ZStack(alignment: .top) {
                    ZStack(alignment: .center) {
                        SpinWheelView(data: (0..<8).map { _ in Double(100/8) })
                            .overlay(
                                Circle()
                                    .stroke(Color.textColor, lineWidth: 7)
                                    .scaleEffect(1.05)
                            )
                        
                        SpinWheelBolt()
                            .shadow(color: Color.black.opacity(0.4), radius: 3, x: 0, y: 0)
                    }
                    .frame(width: Global.screenWidth*0.8, height: Global.screenWidth*0.8)
                    .rotationEffect(.degrees(degree))
                    
                    SpinWheelPointer()
                        .shadow(color: Color.black.opacity(0.4), radius: 3, x: 0, y: 0)
                        .offset(y: -40)
                }
                .padding(.top)
                
                SwipeIndicator(inView: inView)
                    .padding(.vertical)
                    .opacity(isSpinning ? 0 : 1)
                
                Spacer()
            }
            .padding(.bottom,10)
            .frame(maxWidth: .infinity)
            .frame(height: Global.screenHeight * 0.72)
            .background(Color.background)
            .cornerRadius(40, corners: [.topLeft,.topRight])
            .gesture(
                DragGesture().onChanged({ (value) in
                    if value.translation.width < 0 {
                        clockwise = false
                    } else {
                        clockwise = true
                    }
                    setDirection = true
                }).onEnded({ (value) in
                    if !isSpinning {
                        spinWheel()
                        withAnimation(.easeInOut(duration: 0.8)) {
                        isSpinning.toggle()
                        }
                    }
                })
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        
    }
    
    func spinWheel() {
        
        let rndo = Int.random(in: 0..<8)
        let e = p[rndo]
        let r = Double.random(in: -20...20)
        let z = Int.random(in: 0...1)
        if !setDirection {
            clockwise = z == 0 ? true : false
        }
        let f = clockwise ? e : -e
        let final = Double(f) - degree + r
        
        withAnimation(animation) {
            degree += final
        }
        
        system.playSound(String(e), 0.5)
        system.playSpinHaptics(rndo)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            data.getSpinPrize(rndo)
            system.updateSpinTime()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            withAnimation(.easeOut(duration: 2.0)) {
                degree = 0
                isSpinning.toggle()
            }
        }
    }
}


extension FloatingPoint {
    var whole: Self { modf(self).0 }
    var fraction: Self { modf(self).1 }
}
