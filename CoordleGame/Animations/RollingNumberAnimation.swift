//
//  RollingNumberAnimation.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/4/22.
//

import SwiftUI

struct RollingNumberAnimation: View {
    @State var total: Int = 0
    @State var enteredNumber: Int = 0
    @State var showAnimation = false
    var backgroundColor: Color = Color.black
    
    var body: some View {
        HStack {
            // Animation counting number
            ZStack(alignment: .center) {
                // current transaction "price"
                Text("+\(enteredNumber)")
                    .foregroundColor(.green)
                    .offset(x: self.showAnimation ? 70 : 0, y: 0)
                    .scaleEffect(self.showAnimation ? 0.8 : 0, anchor: .trailing)
                    .animation(Animation.spring(dampingFraction: 0.7).speed(0.8))
                
                Text("\(total)")
                    // create a barrier from the total and scaled animation
            }
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.white)
        }.onAppear {
            self.addNumberWithRollingAnimation()
            
        }
    }
}
extension RollingNumberAnimation {
    
    func addNumberWithRollingAnimation() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
        
            withAnimation {
                // show scale animation
                
                // Decide on the number of animation steps
                let animationDuration = 1000 // milliseconds
                let steps = min(abs(self.enteredNumber), 100)
                let stepDuration = (animationDuration / steps)
                
                // add the remainder of our entered num from the steps
                self.total += self.enteredNumber % steps
                
                (0..<steps).forEach { step in
                    let updateTimeInterval = DispatchTimeInterval.milliseconds((step * stepDuration) / 2)
                    let deadline = DispatchTime.now() + updateTimeInterval
                    DispatchQueue.main.asyncAfter(deadline: deadline) {
                        // Add piece of the entire entered number to our total
                        self.total += Int(self.enteredNumber / steps)
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.showAnimation = true
                }
                    
                // hide scale animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    self.showAnimation = false
                }
                
            }
        }
    }
}
