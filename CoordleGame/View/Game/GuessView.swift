//
//  GuessView.swift
//  Coordle
//
//  Created by Graham Furey on 3/27/22.
//

import SwiftUI

struct GuessView: View {
    var bg: Color = Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1))
    var fontSize: CGFloat = 35
    var color: Color = .textColor
    var shake: Int
    var columns: Int
    var guess: Guess
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<columns, id: \.self) { index in
                FlipView(isFlipped: guess.cardFlipped[index]) {
                    Text(guess.guessLetters[index])
                        .foregroundColor(color)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(bg)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.1), lineWidth: 8)
                                .background(Color.clear)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .modifier(Shake(animatableData: CGFloat(shake)))
                } back: {
                    Text(guess.guessLetters[index])
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(guess.bgColors[index])
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.1), lineWidth: 8)
                                .background(Color.clear)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .modifier(Shake(animatableData: CGFloat(shake)))
                }
                .font(.system(size: fontSize, weight: .heavy))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.black.opacity(0.1), lineWidth: 8)
//                        .background(Color.clear)
//                )
                
                
            }
        }
    }
}
