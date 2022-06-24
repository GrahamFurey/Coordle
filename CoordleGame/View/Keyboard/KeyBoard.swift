//
//  KeyBoard.swift
//  Coordle
//
//  Created by Graham Furey on 3/27/22.
//

import SwiftUI

struct Keyboard: View {
    
    @EnvironmentObject var model: DataModel
    @EnvironmentObject var system: SystemFunctions
    var topRowArray = "QWERTYUIOP".map{ String($0) }
    var middleRowArray = "ASDFGHJKL".map{ String($0) }
    var bottomRowArray = "ZXCVBNM".map{ String($0) }
    
    var body: some View {
        VStack(spacing: 4) {
            
            HStack(spacing: 2) {
                ForEach(topRowArray, id: \.self) { letter in
                    KeyView(letter: letter)
                }
                .disabled(model.disabledKeys)
                .opacity(model.disabledKeys ? 0.6 : 1)
//                .shadow(color: .gray, radius: 2, x: 2, y: 3)

            }

            HStack(spacing: 2) {
                ForEach(middleRowArray, id: \.self) { letter in
                    KeyView(letter: letter)
                }
                .disabled(model.disabledKeys)
                .opacity(model.disabledKeys ? 0.6 : 1)
//                .shadow(color: .gray, radius: 2, x: 2, y: 3)

            }

            HStack(spacing: 2) {

                Spacer()

                ForEach(bottomRowArray, id: \.self) { letter in
                    KeyView(letter: letter)
                }
                .disabled(model.disabledKeys)
                .opacity(model.disabledKeys ? 0.6 : 1)
//                .shadow(color: .gray, radius: 2, x: 2, y: 3)

                Button(action: {
                    model.removeLetter()
                    system.playSound("woosh",0.5)
                }) {
                    Image(systemName: "delete.left.fill")
                        .font(.system(size: 20, weight: .heavy))
                        .frame(width: 60, height: 50)
                        .foregroundColor(.textColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .modifier(AddShadow(cr: 10, color: .darkShadow, offsetX: -1, offsetY: 1))
//                                .shadow(color: .gray, radius: 2, x: 2, y: 3)
                            )
                }
                .disabled(!model.inPlay || model.currentWord.count == 0)
                .opacity((!model.inPlay || model.currentWord.count == 0) ? 0.6 : 1)
            }
            .padding(.trailing)

            HStack(spacing: 3) {

                HStack(spacing: 4) {
                    
                    Button(action: {
                        if model.search <= 0 {
                            if model.jewels >= 175 {
                                model.jewels -= 175
                                model.search += 1
                            } else {
                                system.currentView = 1
                            }
                        } else {
                            model.revealOneLetter()
                            model.search -= 1
                        }
                    }) {
                        PowerUpView(inventory: model.search, powerUp: .search)
                    }.buttonStyle(AdvancedButtonStyle())
                    .disabled(!model.inPlay)
                    .opacity(!model.inPlay ? 0.6 : 1)
                    
                    Button(action: {
                        if model.goback <= 0 {
                            if model.jewels >= 200 {
                                model.jewels -= 200
                                model.goback += 1
                            } else {
                                system.currentView = 1
                            }
                        }
                        else { model.goBackOneRow()
                            model.goback -= 1
                        }
                    }) {
                        PowerUpView(inventory: model.goback, powerUp: .goback)
                    }.buttonStyle(AdvancedButtonStyle())
                    .disabled(model.currentRow == 0 || !model.inPlay)
                    .opacity((model.currentRow == 0 || !model.inPlay) ? 0.6 : 1)

                }.frame(maxWidth: .infinity, maxHeight: 45)

                Button(action: {
                    model.enterWord()
                    system.playSound("swoosh",0.5)
                }) {
                    Text(model.overlayText)
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: 200, height: 50)
                        .foregroundColor(.textColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .modifier(AddShadow(cr: 10, color: .darkShadow, offsetX: -1, offsetY: 1))
//                                .shadow(color: .gray, radius: 2, x: 2, y: 3)
                            )
                }
                .disabled(model.currentWord.count < model.totalLetterCount || !model.inPlay)
                .opacity((model.currentWord.count < model.totalLetterCount || !model.inPlay) ? 0.6 : 1)
                
                Button(action: {
                    if model.skip <= 0 {
                        if model.jewels >= 175 {
                            model.jewels -= 175
                            model.skip += 1
                        } else {
                            system.currentView = 1
                        }
                    }
                    else { model.endWithWin()
                        model.goback -= 1
                    }
                }) {
                    PowerUpView(inventory: model.skip, powerUp: .skip)
                }.buttonStyle(AdvancedButtonStyle())
                .disabled(model.currentRow == 0 || !model.inPlay)
                .opacity((model.currentRow == 0 || !model.inPlay) ? 0.6 : 1)

            }
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}
