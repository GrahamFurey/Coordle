//
//  AddShadow.swift
//  CoordleGame
//
//  Created by Graham Furey on 5/1/22.
//

import Foundation
import SwiftUI

struct AddShadow: ViewModifier {
    
    var cr: CGFloat
    var color: Color
    var offsetX: CGFloat
    var offsetY: CGFloat
    var opacity: Bool = true
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cr)
                    .fill(color)
                    .offset(x: offsetX, y: offsetY)
                    .opacity(opacity ? 1 : 0)
            )
    }
}
