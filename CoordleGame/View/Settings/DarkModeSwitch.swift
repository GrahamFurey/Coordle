//
//  DarkModeSwitch.swift
//  CoordleGame
//
//  Created by Graham Furey on 3/31/22.
//

import SwiftUI

struct DarkModeToggle: ToggleStyle {
    
    var light1 = Color(UIColor.init(red: 252/255, green: 192/255, blue: 0/255, alpha: 1.0))
    var light2 = Color(UIColor.init(red: 244/255, green: 148/255, blue: 87/255, alpha: 1.0))
    var light3 = Color(UIColor.init(red: 233/255, green: 108/255, blue: 186/255, alpha: 1.0))
    
    var dark1 = Color(UIColor.init(red: 220/255, green: 116/255, blue: 193/255, alpha: 1.0))
    var dark2 = Color(UIColor.init(red: 120/255, green: 53/255, blue: 146/255, alpha: 1.0))
    var dark3 = Color(UIColor.init(red: 37/255, green: 19/255, blue: 127/255, alpha: 1.0))
    
    var light: Gradient = Gradient(colors: [Color.white])
    var dark: Gradient = Gradient(colors: [Color.black])
    
    init() {
        light = Gradient(colors: [light3, light2, light1])
        dark = Gradient(colors: [dark3, dark2, dark1])
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            LinearGradient(gradient: configuration.isOn ? dark : light, startPoint: .leading, endPoint: .trailing)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    
                    Circle()
                        .fill(Color.white)
                        .padding(.all, 1)
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
        
            
    }
}


