//
//  Header.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/24/22.
//

import SwiftUI

struct Header: View {
    
    @Binding var currentTab: Int
    var jewels: Int
    @Binding var spin: Bool
    @Binding var enterGame: Bool
    
    let offset = -Global.screenHeight*0.2
    
    var body: some View {
        
        HeaderView()
            .offset(y: currentTab == 0 || currentTab == 2 ? (spin || enterGame ? 0 : offset) : 0)
            .animation(.interpolatingSpring(mass: 1, stiffness: 200, damping: 20, initialVelocity: 4))
        
    }

    @ViewBuilder
    func HeaderView(gem: Bool = true, plus: Bool = true)->some View {
        HStack {
            
            Button(action: {
                currentTab = 0
                if spin { spin = false }
                if enterGame { enterGame = false }
            }) {
                
                Image(systemName: "house.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(
                        ZStack {
                            Color.lightBlue
                            
                            RoundedRectangle(cornerRadius: 7, style: .continuous)
                                .fill(Color.black.opacity(0.5))
                                .blur(radius: 3)
                                .offset(x: -2, y: 5)

                            RoundedRectangle(cornerRadius: 7, style: .continuous)
                                .fill(Color.white.opacity(0.5))
                                .blur(radius: 3)
                                .offset(x: 2, y: 5)

                            RoundedRectangle(cornerRadius: 7, style: .continuous)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [.lightBlue,.lighterBlue]), startPoint: .bottomTrailing, endPoint: .topLeading)
                                    )
                                .padding(2)
                                .blur(radius: 2)
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                    .modifier(AddShadow(cr: 9, color: Color.darkShadow.opacity(currentTab == 0 ? 0.3 : 1), offsetX: -3, offsetY: 3))
            
            }
            .buttonStyle(AdvancedButtonStyle())
            
            Spacer()
            
            Button(action: { currentTab = 1}) {
                GemTicker(amount: jewels, plus: plus)
            }
            .opacity(gem ? 1 : 0)
            .disabled(!gem || !plus)
            
        }
        .frame(maxWidth: Global.screenWidth*0.92, maxHeight: 50)
//        .padding(.top,currentTab == 0 ? 0 : 10)
    }
}
