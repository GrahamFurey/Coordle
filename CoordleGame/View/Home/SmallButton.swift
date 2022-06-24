//
//  SmallButton.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/29/22.
//

import SwiftUI

struct SmallButton: View {
    
    var img: String = "cart"
    var color1: Color = .lightBlue
    var color2: Color = .lighterBlue
    
    var unitpoints: [UnitPoint] = [.bottomTrailing,.topLeading]
    var offsetX: CGFloat = -5
    
    var body: some View {
        Image("\(img).fill")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundColor(.white)
            .padding(8)
            .background(
                ZStack {
                    color1
                    
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(Color.black.opacity(0.5))
                        .blur(radius: 3)
                        .offset(x: offsetX, y: 5)

                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(Color.white.opacity(0.5))
                        .blur(radius: 3)
                        .offset(x: -offsetX, y: 5)

                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [color1,color2]), startPoint: unitpoints[0], endPoint: unitpoints[1])
                            )
                        .padding(2)
                        .blur(radius: 2)
                }
            ).clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .modifier(AddShadow(cr: 9, color: Color.darkShadow, offsetX: offsetX, offsetY: 3))
            .frame(width: 60, height: 60)
    }
}

struct SmallButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallButton()
    }
}
