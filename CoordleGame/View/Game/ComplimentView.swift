//
//  ComplimentView.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/5/22.
//

import SwiftUI
import ConfettiSwiftUI

struct ComplimentView: View {
    
    var compliment: String
    
    @State var hueRotate = false
    @State var enter = false
    @State var activate = false
    @State var activate2 = false
    @State var showFireworks = 0
    
    var body: some View {
        
        ZStack {
            
            ConfettiCannon(counter: $showFireworks, num: 30, fadesOut: true, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200, repetitions: 3, repetitionInterval: 0.1)
        
            Text(compliment)
                .foregroundColor(Color.rainbow1)
                .font(.system(size: 30, weight: .bold))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 20)
                )
                .offset(y: enter ? 0 : -1000)
                .opacity(activate ? 0 : 1)
            
            Text(compliment)
                .foreground(
                    LinearGradient(gradient: rainbow(),
                                   startPoint: .bottomLeading,
                                   endPoint: .topTrailing)
                        .hueRotation(.degrees(hueRotate ? -600 : .pi * 450))
                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false), value: hueRotate)        .onAppear {
                            DispatchQueue.main.async {
                            self.hueRotate.toggle()
                            }
                        }
                )
                .font(.system(size: 30, weight: .bold))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(color: .white, radius: 10)
                )
                .opacity(activate ? 1 : 0)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(enter ? 0.2 : 0))
        .edgesIgnoringSafeArea(.all)
        .onChange(of: compliment) { _ in
            
            withAnimation(Animation.interactiveSpring(response: 1.0, dampingFraction: 0.9, blendDuration: 1.0)) {
                enter.toggle()
            }
            
            withAnimation(Animation.default.delay(0.9)) {
                activate.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                
                showFireworks += 1
            }
            
                hueRotate.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(Animation.interactiveSpring(response: 1.0, dampingFraction: 0.9, blendDuration: 1.0)) {
                    enter.toggle()
                }
                activate.toggle()
                hueRotate.toggle()
            }
        }
    }
}
    
func rainbow() -> Gradient {
    let color1 = Color(UIColor(red: 166/255, green: 204/255, blue: 250/255, alpha: 1.0))
    let color2 = Color(UIColor(red: 228/255, green: 179/255, blue: 224/255, alpha: 1.0))
    let color3 = Color(UIColor(red: 251/255, green: 229/255, blue: 236/255, alpha: 1.0))
    let color4 = Color(UIColor(red: 243/255, green: 181/255, blue: 225/255, alpha: 1.0))
    
    return Gradient(stops: [Gradient.Stop(color: color1, location: 0.4),
                                      Gradient.Stop(color: color2, location: 0.5),
                                      Gradient.Stop(color: color3, location: 0.75),
                                      Gradient.Stop(color: color4, location: 1.0)])
}
