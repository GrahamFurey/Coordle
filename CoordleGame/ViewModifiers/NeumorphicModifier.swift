//
//  NeumorphicModifier.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/24/22.
//

import SwiftUI

struct NeumorphicModifier: ViewModifier {
    var colors = [Color.startGradient, Color.lightShadow]
    var unitPoints = [UnitPoint.topLeading, .bottomTrailing]
    var lightShadow: Color = Color.lightShadow
    var darkShadow: Color = Color.darkShadow
    var cr: CGFloat = 15
    var spread: CGFloat = 3
    var blur: CGFloat = 4
    var blurOffset: CGFloat = -8
    var flipped = false
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    darkShadow

                    RoundedRectangle(cornerRadius: cr, style: .continuous)
                        .foregroundColor(.lightShadow)
                        .blur(radius: blur)
                        .offset(x: blurOffset, y: blurOffset)

                    RoundedRectangle(cornerRadius: cr, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: colors), startPoint: unitPoints[0], endPoint: unitPoints[1])
                            )
                        .padding(2)
                        .blur(radius: 2)
                }
            ).clipShape(RoundedRectangle(cornerRadius: cr, style: .continuous))
            .modifier(AddShadow(cr: cr, color: lightShadow, offsetX: -spread, offsetY: -spread))
            .modifier(AddShadow(cr: cr, color: darkShadow, offsetX: spread, offsetY: spread))
//            .shadow(color: lightShadow, radius: spread, x: -spread, y: -spread)
//            .shadow(color: darkShadow, radius: spread, x: spread, y: spread)
    }
}
