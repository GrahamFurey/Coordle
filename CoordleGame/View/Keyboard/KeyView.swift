//
//  LetterButtonView.swift
//  Coordle
//
//  Created by Graham Furey on 3/27/22.
//

import SwiftUI

struct KeyView: View {
    
    @EnvironmentObject var model: DataModel
    @EnvironmentObject var system: SystemFunctions
    var letter: String
    
    var body: some View {
        
        Button(action: {
            model.addToCurrentWord(letter)
            system.playSound("key",0.3)
        }) {
            
            let c = model.keyColors[letter]
            
            Text(letter)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .frame(width: 35, height: 50)
                .foregroundColor(c == Color.second ? Color.blackText : Color.white)
                .background(c)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .modifier(AddShadow(cr: 5, color: Color.darkShadow, offsetX: -1, offsetY: 1))
        }
    }
}
