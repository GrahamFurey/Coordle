//
//  TextShimmer.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/4/22.
//

import SwiftUI

struct TextShimmer: View {
    
    var text: String
    @State var animation = false
    @Binding var multiColors: Bool
    
    var body: some View{
        
        ZStack{
            
            Text(text)
                .font(.system(size: 75, weight: .bold))
                .foregroundColor(Color.white.opacity(0.25))
            
            // MultiColor Text....
            
            HStack(spacing: 0){
                
                ForEach(0..<text.count,id: \.self){index in
                    
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(.system(size: 75, weight: .bold))
                        .foregroundColor(multiColors ? randomColor() : Color.white)
                }
            }
            // Masking For Shimmer Effect...
            .mask(
            
                Rectangle()
                    // For Some More Nice Effect Were Going to use Gradient...
                    .fill(
                    
                        // You can use any Color Here...
                        LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5),Color.white,Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .padding(20)
                // Moving View Continously...
                // so it will create Shimmer Effect...
                    .offset(x: -250)
                    .offset(x: animation ? 500 : 0)
            )
            .onAppear(perform: {
            
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)){
                    
                    animation.toggle()
                }
            })
        }
    }
    
    // Random Color....
    
    // It's Your Wish yOu can change anything here...
    // or you can also use Array of colors to pick random One....
    
    func randomColor()->Color{
        
        let color = UIColor(red: 1, green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        return Color(color)
    }
}

struct GoldShimmer: View {
    
    var text: String
    @State var animation = false
    var size: CGFloat = 22
    
    let colors = [Color.gold1.opacity(0.8),Color.gold2.opacity(0.8)]
    
    var body: some View{
        
        ZStack{
            
            Text(text)
                .font(.system(size: size, weight: .heavy))
                .foreground(
                    LinearGradient(gradient: .init(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
            
            // MultiColor Text....
            
            HStack(spacing: 0){
                
                ForEach(0..<text.count,id: \.self){index in
                    
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(.system(size: size, weight: .heavy))
                        .foregroundColor(Color.gold1)
                }
            }
            // Masking For Shimmer Effect...
            .mask(
            
                Rectangle()
                    // For Some More Nice Effect Were Going to use Gradient...
                    .fill(
                        
                        // You can use any Color Here...
                        LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5),Color.white,Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
//                        LinearGradient(gradient: .init(colors: [Color.gold1.opacity(0.5),Color.gold1,Color.gold1.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 40))
                // Moving View Continously...
                // so it will create Shimmer Effect...
                    .offset(x: -120)
                    .offset(x: animation ? 240 : 0)
            )
            .onAppear(perform: {
            
                withAnimation(Animation.linear(duration: 1.5).delay(0.5).repeatForever(autoreverses: false)){
                    
                    animation.toggle()
                }
            })
        }
    }
}

