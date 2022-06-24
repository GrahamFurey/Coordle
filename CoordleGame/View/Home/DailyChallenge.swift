//
//  DailyChallenge.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/9/22.
//

import SwiftUI

struct DailyMain: View {
    
    let lightGreen = Color(UIColor(red: 131/255, green: 212/255, blue: 116/255, alpha: 1.0))
    let darkGreen = Color(UIColor(red: 44/255, green: 182/255, blue: 44/255, alpha: 1.0))
    
    @Binding var completed: Bool
    
    var body: some View {
            ZStack {
                if !completed {
                    Text("Daily Challenge")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                else {
                    TimerTillTomorrow(disabled: $completed)
                }
            }
            .padding(10)
            .padding(.horizontal)
            .frame(width: Global.screenWidth * 0.65)
            .background(
                ZStack {
                    completed ? Color(UIColor.lightGray) : darkGreen

                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.white)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(stops: [
                                .init(color: completed ? Color(UIColor.lightGray) : lightGreen, location: 0),
                                .init(color: completed ? Color(UIColor.lightGray) : darkGreen, location: 1.0),
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                        .padding(2)
                        .blur(radius: 2)
                }
                .shadow(color: Color.gray, radius: 5, x: 3, y: 3)
                .shadow(color: Color.white, radius: 5, x: -3, y: -3)
                    
            ).clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct DailyStreak: View {
    
    var streak: Int
    
    var body: some View {
        Text("\(streak) Day Streak")
            .font(.system(size: 18))
            .fontWeight(.semibold)
            .foregroundColor(.gray.opacity(0.7))
            .padding(7)
            .padding(.horizontal, 7)
            .frame(width: Global.screenWidth * 0.55)
            .modifier(NeumorphicModifier(cr: 10, blur: 2, blurOffset: 4))
    }
}
