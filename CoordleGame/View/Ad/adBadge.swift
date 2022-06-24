//
//  adBadge.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/9/22.
//

import SwiftUI

struct adBadge: View {
    
    var color = Color.purple
    
    var body: some View {
        
        Image(systemName: "play.rectangle")
            .font(.system(size: 80, weight: .semibold))
            .foregroundColor(.white)
            .padding(2)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(color)
                    .shadow(color: Color.gray, radius: 3, x: 3, y: 3)
            )
            
            .overlay(
            DoubleBadge()
                .offset(x: 45, y: 35)
            )
            
    }
}

struct DoubleBadge: View {
    
    var text = "X2"
    
    var body: some View {
        
        Text(text)
            .font(.system(size: 24))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(12)
            .background(
                
                Image("badge")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(Color.yellow)
                    .shadow(color: Color.gray, radius: 3, x: 3, y: 3)
                
            )
            .rotationEffect(Angle.degrees(340))
        
    }
}

struct adBadge_Previews: PreviewProvider {
    static var previews: some View {
        adBadge()
    }
}
