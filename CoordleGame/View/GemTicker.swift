//
//  GemTicker.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/4/22.
//

import SwiftUI

struct GemTicker: View {
    
    var amount: Int
    var plus: Bool
    
    var body: some View {
        
        HStack(spacing: 7) {
            
            Text(amount.abbreviate())
                .font(.system(size: 18))
                .fontWeight(.heavy)
                
                .foregroundColor(.white)
            
                Image("gem3D")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 27)
                    .shadow(color: Color(.black).opacity(0.6), radius: 4, x: 2, y: 3)
                    .fixedSize()
            
        }.padding(.vertical, 2)
        .padding(.trailing, 6)
        .padding(.leading)
        
        .background(
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.2))
        
        )
        .overlay(
            Image(systemName: "plus")
                .font(.system(size: 12, weight: .bold, design: .default))
                .foregroundColor(.white)
                .padding(3)
                .background(
                    Circle()
                        .fill(Color.green)
                )
                .shadow(color: .gray, radius: 10, x: 2, y: 3)
                .opacity(plus ? 1 : 0)
                .offset(x: 3, y: 7)
        , alignment: .bottomTrailing)
        
    }
}

struct GemTicker_Previews: PreviewProvider {
    static var previews: some View {
        GemTicker(amount: 100, plus: true)
    }
}
