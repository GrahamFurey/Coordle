//
//  HorizontalGraph.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/15/22.
//

import SwiftUI

struct HorizontalGraph: View {
    
    @State var tappedNum = 0 //set to currentRow
    var stat: Statistic
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            let count = stat.frequencies.count
            let wins = Double(stat.wins)
            let highest = Double(stat.frequencies.max() ?? 0)
        
            ForEach(0..<count, id: \.self) { row in
                
                let top = Double(stat.frequencies[row])
                let p = wins == 0 ? 0 : top/wins
                
                GraphRow(num: row + 1, delay: Double(row)*0.2, percent: p, ratio: p/highest, isTapped: $tappedNum)
                    
            }
            
        }.onAppear {
            tappedNum = Int.random(in: 0...stat.frequencies.count)
        }
    }
}

struct GraphRow: View {
    
    @State var width: CGFloat = 0
    
    var num: Int
    var delay: Double
    var percent: Double
    var ratio: Double
    
    @Binding var isTapped: Int
    
    var body: some View {
        
        
        HStack(spacing: 7) {
            
            
            Text("\(num)")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.textColor)
            
        
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.clear)
                    .modifier(NeumorphicModifier(colors: [Color.white, Color.background], cr: 5, blur: 1, blurOffset: 1))
                
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.black.opacity(0.1), lineWidth: 5)
                    .background(
                        
                        Group {
                            if isTapped == num {
                                Color.correct
                            } else {
                                Color.wrong
                            }
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(
                    
                        Text("\(Int(percent*100))%")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.trailing, 5)
                            .opacity(isTapped == num ? 1 : 0)
                        , alignment: .trailing
                    
                    )
                    .frame(width: width)
                    .padding(2)
                
            }.frame(height: Global.screenHeight / 25)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                isTapped = num
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 0.5).delay(delay)) {
                if !ratio.isNaN && ratio != 0 {
                    width = (Global.screenWidth*0.7) * ratio
                } else {
                    width = (Global.screenWidth*0.1)
                }
            }
        }
        
    }
}
