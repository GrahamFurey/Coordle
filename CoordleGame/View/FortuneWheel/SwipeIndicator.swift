//
//  SwipeIndicator.swift
//  CoordleGame
//
//  Created by Graham Furey on 5/2/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SwipeIndicator: View {
    
    @State var space = false
    @State var enter = false
    let color = Color.black.opacity(0.5)
    let string = ["S","W","I","P","E"]
    
    var inView: Bool
    
    var body: some View {
        
        VStack(spacing: 3) {
            HStack(spacing: 15) {
                
                Image("straightArrow")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: space ? 70 : 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(color)
                    .rotationEffect(.degrees(180))
                
                AnimatedImage(name: "handGesture.gif")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.5)
                    .frame(width: 60)
                
                Image("straightArrow")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: space ? 70 : 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(color)
                
            }
            
            HStack(spacing: space ? 10 : 0) {
                ForEach(string, id: \.self) { s in
                    Text(s)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(color)
                }
            }
            
        }
        .offset(x: enter ? 0 : Global.screenWidth)
        .onChange(of: inView) { val in
            if val {
                repeatForever()
                withAnimation(.spring()) {
                    enter.toggle()
                }
            } else {
                withAnimation(Animation.linear) {
                    space = val
                }
            }
        }
    }
    
    func repeatForever() {
        withAnimation(.easeInOut(duration: 1.7).repeatForever()) {
            space.toggle()
        }
    }
}

struct SwipeIndicator_Previews: PreviewProvider {
    static var previews: some View {
        SwipeIndicator(inView: true)
    }
}
