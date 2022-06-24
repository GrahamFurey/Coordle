//
//  PFPView.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/26/22.
//

import SwiftUI

struct ItemView: View {
    
    var item: Item
    var lw = 10.0
    var stroke = 0.1
    
    var body: some View {
            Image(item.img)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(0.8)
                .background(item.color)
                .opacity(item.unlocked ? 1 : 0.6)
                .grayscale(item.unlocked ? 0 : 0.6)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black.opacity(stroke), lineWidth: lw)
                        .background(Color.clear)
                        .grayscale(item.unlocked ? 0 : 0.7)
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
