//
//  GameView.swift
//  Coordle
//
//  Created by Graham Furey on 3/27/22.
//

import Combine
import SwiftUI

struct GameView: View {
    @EnvironmentObject var model: DataModel
    @EnvironmentObject var player: PlayerModel
    @EnvironmentObject var system: SystemFunctions
    
//    var gameTitle: GameTitle
    @Binding var isShowing: Bool
    @State var shake: CGFloat = 0.0
    @State var go = ""
    
    @State var cardShown = false
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 20) {
                
//                Spacer().overlay(
//
//                    HStack {
//
//
//                        Spacer().overlay(
//                            Button(action: {
//
//                                withAnimation {
//                                    exitGame.toggle()
//                                }
//
//                            }) {
//
//                            Image(systemName: "chevron.left")
//                                .font(.system(size: 30, weight: .regular))
//                                .foregroundColor(.textColor)
//                            }
//                            .fixedSize(horizontal: true, vertical: false),
//                            alignment: .leading
//                        )
//
//                        TitleView(cardShown: $cardShown)
//                            .environmentObject(model)
//                            .frame(alignment: .center)
//                            .padding(.leading, 15)
//
//                        Spacer().overlay(
//
//                            GemTicker(amount: model.jewels, plus: true)
//                                .fixedSize(horizontal: true, vertical: false),
//                            alignment: .trailing
//                        )
//
//                    }.padding(.horizontal)
//                    .frame(width: Global.screenWidth)
//
//                )
                
                VStack(spacing: 3) {
                    let count = model.totalLetterCount
 
                    ForEach(0...count, id: \.self) { index in
                        GuessView(shake: model.shake[index], columns: count, guess: model.guesses[index])
                            .modifier(Shake(animatableData: CGFloat(model.shake[index])))
                    }
                    
                }.frame(width: Global.boardWidth, height: 6 * Global.boardWidth / 5)
//                .position(x: Global.screenWidth / 2, y: Global.screenHeight / 3)
                
                
                Keyboard()
                    .scaleEffect(Global.keyboardScale)
                    .padding(.top, 20)
            
            }
            .padding(.vertical, 40)
            .padding(.top,40)
            
            ComplimentView(compliment: model.toastText)
            
            BottomCard(cardShown: $cardShown, height: Global.screenHeight / 2.2)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .offset(x: model.gameOver ? -(Global.screenWidth) : 0)
        .opacity(model.gameOver ? 0 : 1)
        .edgesIgnoringSafeArea(.all)
        .overlay(
            EndScreen()
                .offset(x: model.gameOver ? 0 : (Global.screenWidth))
                .opacity(model.gameOver ? 1 : 0)
        )
    }
}
