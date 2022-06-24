//
//  SpinWheelButton.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/23/22.
//

import SwiftUI

struct SpinWheelButton: View {
    
    @EnvironmentObject var system: SystemFunctions
    @State private var bounce: CGFloat = 0
    @Binding var disabled: Bool
    @Binding var spin: Bool
    
    var body: some View {
        
        Button(action: {
            
            system.playSound("bling",0.5)
            spin.toggle()
            
        }) {
        
        VStack(spacing: 3) {
        
            Image("bet")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .background(
                    Image("bet")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.textColor)
                        .frame(width: 57, height: 57)
                )
                .offset(y: bounce)
            

            ZStack {
                if disabled {
                TimerTillTomorrow(disabled: $disabled, tomorrow: system.lastSpin, font: 15)
                    .foregroundColor(.textColor)
                    .opacity(disabled ? 1 : 0)
                    .padding(.bottom)
                } else {
                
                Text("SPIN")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(4)
                    .padding(.horizontal, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.redC)
                            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 2, y: 2)
                    )
                    .padding(.top, 5)
                }
            
                }
                .fixedSize(horizontal: true, vertical: true)
            }
        }
        .opacity(disabled ? 0.7 : 1)
//        .disabled(disabled)
        .onChange(of: disabled) { val in
            if !val {
                jump()
            }
        }
    }
    
    func jump(_ start: CGFloat = -25) {
        withAnimation(Animation.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0.7)) {
            bounce = start
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(Animation.interpolatingSpring(stiffness: 350, damping: 7, initialVelocity: 15)) {
                bounce = -10
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeIn(duration: 0.1)) {
                bounce = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if !disabled {
                jump()
            }
        }
    }
}
