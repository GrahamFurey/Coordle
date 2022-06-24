//
//  StaticSparkle.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/13/22.
//

import SwiftUI

struct StaticSparkle: View {
    @State var spawn = false
    var delay: Double = 0
    
    var body: some View {
        
        Image(systemName: "sparkle")
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(.white)
            .opacity(spawn ? 1 : 0)
            .shadow(color: .white.opacity(0.7), radius: 3, x: 3, y: 3)
            .scaleEffect(spawn ? 1.0 : 0.2)
        
            .onAppear {
                
                    mainAnimation()
            }
        
    }
    
    func mainAnimation() {
        withAnimation(Animation.linear.delay(delay)) {
            spawn = true
        }
    }
}

struct StaticSparkle_Previews: PreviewProvider {
    static var previews: some View {
        StaticSparkle()
    }
}
