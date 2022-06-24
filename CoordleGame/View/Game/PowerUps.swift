//
//  PowerUps.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/8/22.
//

import SwiftUI


import SwiftUI

enum PowerUp {
    case search
    case goback
    case skip
    
    func cost() -> Int {
        switch self {
        case .search:
            return 175
        case .goback:
            return 200
        case .skip:
            return 225
        }
    }
}

struct PowerUpView: View {
    
    var inventory: Int
    var powerUp: PowerUp
    
    var body: some View {
        
        Group {
            switch powerUp {
            case .search:
                Search()
            case .goback:
                GoBack()
            case .skip:
                Skip()
            }
        }
        .overlay(
        
            powerOverlay(inventory: inventory,
                         cost: powerUp.cost(),
                         width: powerUp == .skip ? 140 : 60,
                         xOffset: powerUp == .skip ? 25 : 13,
                         xPadding: powerUp == .skip ? 10 : 3
                        )
            
            , alignment: .bottom
        )
        
    }
}

struct Search: View {
    
    var padding: CGFloat = 8
    var cr: CGFloat = 10
    var shadow: Color = Color.black.opacity(0.5)
    
    var body: some View {
        Image("search")
            .resizable()
            .scaledToFill()
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cr)
                    .fill(LinearGradient(
                            gradient: Gradient(colors:
                                                [Color(UIColor(red: 104/255, green: 230/255, blue: 255/255, alpha: 1.0)),
                                                 Color(UIColor(red: 6/255, green: 161/255, blue: 255/255, alpha: 1.0))]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    .background(
                        RoundedRectangle(cornerRadius: cr)
                            .fill(Color.white)
                            .shadow(color: shadow, radius: 2, x: 2, y: 3)
                        )
            
            )
    }
}

struct powerOverlay: View {
    
    var inventory: Int
    var cost: Int
    var width: CGFloat
    var xOffset: CGFloat
    var xPadding: CGFloat
    
    var body: some View {
        if inventory != 0 {
            
            Text("\(inventory)")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(2)
                .padding(.horizontal, 3)
                .background(
                
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.yellow)
                        .shadow(color: .gray, radius: 2, x: 2, y: 3)
                
                )
                .offset(x: xOffset, y: 7)
        
        } else {
    
            HStack(spacing: 1) {
                
                Text("\(cost)")
                    .font(.system(size: 13))
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                
                    Image("gem3D")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 13)
                        .shadow(color: Color(.black).opacity(0.6), radius: 2, x: 2, y: 2)
                
            }
            .padding(.vertical, 2)
            .padding(.horizontal, xPadding)
            
            .background(
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.8))
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
            
            )
            .frame(width: width)
            .offset(y: 12)
            
        }
    }
}

struct GoBack: View {
    var padding: CGFloat = 8
    var cr: CGFloat = 10
    var shadow: Color = Color.black.opacity(0.5)
    var body: some View {
        Image("goback")
            .resizable()
            .scaledToFill()
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cr)
                    .fill(LinearGradient(
                            gradient: Gradient(colors:
                                                [Color(UIColor(red: 255/255, green: 103/255, blue: 109/255, alpha: 1.0)),
                                                 Color(UIColor(red: 250/255, green: 4/255, blue: 48/255, alpha: 1.0))]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    .background(
                        RoundedRectangle(cornerRadius: cr)
                            .fill(Color.white)
                            .shadow(color: shadow, radius: 2, x: 2, y: 3)
                        )
            
            )
    }
}

struct Skip: View {
    var padding: CGFloat = 8
    var cr: CGFloat = 10
    var shadow: Color = Color.black.opacity(0.5)
    var body: some View {
        Image("skip")
            .resizable()
            .scaledToFill()
            .padding(padding)
            .padding(.horizontal, padding*1.5)
            .background(
                RoundedRectangle(cornerRadius: cr)
                    .fill(LinearGradient(
                            gradient: Gradient(colors:
                                                [Color(UIColor(red: 38/255, green: 185/255, blue: 154/255, alpha: 1.0)),
                                                 Color(UIColor(red: 51/255, green: 144/255, blue: 124/255, alpha: 1.0))]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    .background(
                        RoundedRectangle(cornerRadius: cr)
                            .fill(Color.white)
                            .shadow(color: shadow, radius: 2, x: 2, y: 3)
                        )
            
            ).frame(maxWidth: .infinity, maxHeight: 45)
    }
}
