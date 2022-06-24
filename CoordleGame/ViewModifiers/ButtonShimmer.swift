//
//  ButtonShimmer.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/9/22.
//

import SwiftUI

struct ButtonShimmer: View {
    
    var inView: Bool
    @State var show = false
    var delay: CGFloat = 0
    var center = Global.screenWidth / 2 + 110
    var opacity = 0.48
    var degrees = 70.0
    var endPointBottom = true
    
    var body: some View {
        Color.white
            .cornerRadius(16)
            .mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: .init(colors: [.clear, Color.white.opacity(opacity)]), startPoint: .top, endPoint: endPointBottom ? .bottom : .center)
                    
                    )
                    .rotationEffect(.init(degrees: degrees))
                    .offset(x: self.show ? center : -center)
                
            
            ).onAppear {
                repeatForever()
            }.onChange(of: inView) { val in
                
                if val {
                    repeatForever()
                } else {
                    withAnimation(Animation.linear) {
                        show = val
                    }
                }
            }
    }
    
    func repeatForever() {
        withAnimation(Animation.default.speed(0.15)
            .repeatForever(autoreverses: false).delay(delay)) {
            
            self.show.toggle()
            
        }
    }
}
