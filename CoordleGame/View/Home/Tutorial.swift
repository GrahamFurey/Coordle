//
//  Tutorial.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/21/22.
//

import SwiftUI

struct Tutorial: View {
    
    @Binding var isPresented: Bool
    @State var guesses = [Guess]()
    let test = Guess(count: 6, index: 0)
    
    var body: some View {
        VStack {
            
            Text("HOW TO PLAY")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 5)
                .padding(.top, 10)
            
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack(spacing: 0) {
                    Text("Guess the word in a ")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white)
                    Text("limited")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    Text(" number of tries.")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white)
                }
                
                HStack(spacing: 0) {
                    Text("Each guess must be a ")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white)
                    Text("valid")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    Text(" word.")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white)
                }
                
                Text("After each guess, the color of the tiles will change to show how close your guess was.")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.white)
            }
            
            Divider()

        
            HStack {
            VStack(alignment: .leading) {
                
                Text("EXAMPLES")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    
                    GuessView(bg: .blackText, fontSize: 30, color: .white, shake: 0, columns: 5, guess: guesses.indices.count >= 1 ? guesses[0] : test)
                        .frame(width: Global.boardWidth * 0.8, height: (Global.boardWidth / 5)*0.8)
                    
                    HStack(spacing: 0) {
                        Text("The letter ")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.white)
                        
                        Text("A")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text(" is in the correct spot.")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.white)
                        
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    
                    GuessView(bg: .blackText, fontSize: 30, color: .white, shake: 0, columns: 5, guess: guesses.indices.count >= 2 ? guesses[1] : test)
                        .frame(width: Global.boardWidth * 0.8, height: (Global.boardWidth / 5)*0.8)
                    
                    HStack(spacing: 0) {
                        Text("The letter ")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.white)
                        
                        Text("U")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text(" is in the wrong spot.")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.white)
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    
                    GuessView(bg: .blackText, fontSize: 30, color: .white, shake: 0, columns: 5, guess: guesses.indices.count >= 3 ? guesses[2] : test)
                        .frame(width: Global.boardWidth * 0.8, height: (Global.boardWidth / 5)*0.8)
                    
                    HStack(spacing: 0) {
                        Text("The letter ")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.white)
                        
                        Text("R")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text(" is not in the word.")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.white)
                    }
                    
                }
                
            }
                
                Spacer()
                
            }
            
            Divider()
            
            HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("POWER-UPS")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.bottom,5)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Search()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                        Text("HINT")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Text("Reveals one correct letter")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        GoBack()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                        Text("REVERSE")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Text("Goes back one row")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Skip(padding: 6)
                            .scaledToFit()
                            .frame(width: 52.5, height: 35)

                        Text("SKIP")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    }

                    Text("Skip the current word without losing")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
        }
        }
        .padding(.horizontal, 20)
        .padding(.bottom,20)
        .overlay(
        
                Image(systemName: "xmark")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.gray.opacity(0.7))
                    .onTapGesture {
                        isPresented.toggle()
                    }
                    .offset(x: -25, y: 25)
            , alignment: .topTrailing
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blackText)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            
            guesses.append(Guess(index: 0, word: "ALIEN", maxLength: 5))
            guesses.append(Guess(index: 0, word: "FUNNY", maxLength: 5))
            guesses.append(Guess(index: 0, word: "LEARN", maxLength: 5))
            
            guesses[0].bgColors[0] = .correct
            guesses[1].bgColors[1] = .misplaced
            guesses[2].bgColors[3] = .wrong
            
            guesses[0].cardFlipped[0].toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { guesses[1].cardFlipped[1].toggle() }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { guesses[2].cardFlipped[3].toggle() }
            
        }
    }
}

struct Tutorial_Previews: PreviewProvider {
    static var previews: some View {
        Tutorial(isPresented: .constant(true))
    }
}
