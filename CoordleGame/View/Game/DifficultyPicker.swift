//
//  DifficultyPicker.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/6/22.
//

import SwiftUI

struct DifficultyPicker: View {
    
    @Binding var level: Level
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1))
        
            VStack(spacing: 5) {
                
                Spacer()
                
                Difficulty(levelChoice: $level, level: Level.easy, difficulty: "Easy", letters: 4, color: Color.green, img: "zzz")
                Difficulty(levelChoice: $level, level: Level.normal, difficulty: "Normal", letters: 5, color: Color.yellowC, img: "sun.max.fill")
                Difficulty(levelChoice: $level, level: Level.hard, difficulty: "Hard", letters: 6, color: Color.orangeC, img: "bolt.fill")
                Difficulty(levelChoice: $level, level: Level.extreme, difficulty: "Extreme", letters: 7, color: Color.redC, img: "flame.fill")
                RandomDifficulty(levelChoice: $level)
                
                Spacer()
                
            }
            .padding()
            .padding(.horizontal, 50)
            
        }.frame(maxWidth: .infinity)
        
    }
}

struct RandomDifficulty: View {
    
    @Binding var levelChoice: Level
    @State var hueRotate = false
    
    var body: some View {
        
        Button(action: {
            levelChoice = Level.random
        }) {
        
            VStack(alignment: .center) {
                
                HStack(spacing: 3) {
                    
                    Image(systemName: "shuffle")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.textColor)
                
                    Text("Random")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.textColor)
                    
                }
                
            }.padding()
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellowC, Color.orangeC, Color.redC]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
                    .hueRotation(.degrees(hueRotate ? -400 : .pi * 300))
            )
            .opacity(levelChoice == Level.random ? 1 : 0.7)
            .onAppear {
                withAnimation(Animation.easeInOut.speed(0.1).repeatForever()) {
                    hueRotate.toggle()
                }
            }
        }
    }
    
}

struct Difficulty: View {
    
    @Binding var levelChoice: Level
    var level: Level
    var difficulty: String
    var letters: Int
    var color: Color
    var img: String
    
    var body: some View {
        
        Button(action: {
            levelChoice = level
        }) {
        
            VStack(alignment: .center) {
                
                HStack(spacing: 3) {
                    
                    Image(systemName: img)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.textColor)
                
                    Text(difficulty)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.textColor)
                    
                    
                }
                
                Text("\(letters)-letter words")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.textColor)
                
            }.padding(.vertical, 12)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                    .shadow(color: .gray, radius: 2, x: 2, y: 3)
            )
            .opacity(levelChoice == level ? 1 : 0.7)
        
        }
    }
    
}

//struct DifficultyPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomCard(cardShown: .constant(true), height: Global.screenHeight / 2.2)
//    }
//}

struct BottomCard: View {
    
    @EnvironmentObject var model: DataModel
    @Binding var cardShown: Bool
    let height: CGFloat
    @State var test = ""
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .opacity(cardShown ? 0.2 : 0)
                .animation(Animation.easeIn)
                .onTapGesture {
                    self.dismiss()
                }
            
            VStack {
                
                Spacer()
                
                VStack {
                    
                    DifficultyPicker(level: $model.level)
                    
                }
                .frame(height: height)
                .cornerRadius(50, corners: [.topLeft, .topRight])
                .offset(y: cardShown ? 0 : height)
//                .animation(Animation.default.delay(0.2))
                
            }
            
            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
    func dismiss() {
        model.newGame()
        
        withAnimation(Animation.easeIn(duration: 0.3)) {
            cardShown.toggle()
        }
        
    }
    
    
}
