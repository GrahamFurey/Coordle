//
//  EndScreen.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/19/22.
//

import SwiftUI

struct EndScreen: View {
    
    @StateObject var model: DataModel = DataModel()
    @State var guess = Guess(count: 5, index: 0)
    var offset = false
    
    var body: some View {
        
        VStack(spacing: 20) {
                
            VStack(spacing: 7) {
                
                    Text("The word was")
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundColor(.textColor)
                
                    GuessView(shake: 0, columns: model.totalLetterCount, guess: guess)
                        .frame(height: Global.boardWidth / 5)
                        .scaleEffect(0.9)
                }
            
            
                VStack {
                    Text("Guess Distribution")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.textColor)
                    HorizontalGraph(stat: model.currentStat)
                }
                .padding()
                .padding(.horizontal, 10)
                .padding(.bottom,5)
                .modifier(NeumorphicModifier(colors: [Color.white, Color.background], cr: 12, blur: 2, blurOffset: 2))
            
                
                Button(action: {
                    
                    model.newGame()
                    
                }) {
                
                    HStack {
                        
                        Text("NEW ROUND")
                            .font(.system(size: 25, weight: .heavy))
                            .foregroundColor(.white)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [.lighterBlue,.lightBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                    .shadow(color: Color.black.opacity(0.6), radius: 2, x: 2, y: 2)
                            )
                        
                        Image(systemName: "gobackward")
                            .font(.system(size: 25, weight: .heavy))
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(40))
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [.lighterBlue,.lightBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                    .shadow(color: Color.black.opacity(0.6), radius: 2, x: 2, y: 2)
                            )
                        
                    }
                }.buttonStyle(AdvancedButtonStyle())
                
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .edgesIgnoringSafeArea(.all)
//        .overlay(
//
//            HStack {
//
//                Button(action: {
//                    exitGame.toggle()
//                    showTab.toggle()
//                }) {
//
//                Image(systemName: "house.fill")
//                    .font(.system(size: 25, weight: .semibold))
//                    .foregroundColor(.white)
//                    .padding(8)
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .foreground(
//                                LinearGradient(gradient: Gradient(colors: [.lighterBlue,.lightBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                            )
//                            .shadow(color: Color.black.opacity(0.6), radius: 3, x: 3, y: 3)
//                    )
//                }.buttonStyle(BounceButtonStyle())
//
//                Spacer()
//
//                GemTicker(amount: model.jewels, plus: true)
//
//            }.frame(maxHeight: 50)
//            .padding(.horizontal)
//
//            , alignment: .top
//
//        )
        .onChange(of: model.gameOver) { newValue in
            if newValue {
                model.totalLetterCount = 5
                guess = Guess(index: 0, word: model.correctWord, maxLength: model.totalLetterCount)
                for col in 0..<model.totalLetterCount {

                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(col) * 0.2) {

                        self.guess.bgColors[col] = .redC
                        self.guess.cardFlipped[col].toggle()
                    }
                }
            }
        }
    }
}

struct yeowowiow: PreviewProvider {
    
    static var previews: some View {
        EndScreen()
    }
}
