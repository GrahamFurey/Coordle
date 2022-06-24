//
//  PlayButton.swift
//  Coordle
//
//  Created by Graham Furey on 3/26/22.
//

import SwiftUI

struct Buttons: View {
    @EnvironmentObject var model: DataModel
    @EnvironmentObject var system: SystemFunctions
    @Binding var presentError: Bool
    @Binding var startGame: Bool
    
    var inView: Bool { system.currentView == 0 }
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            VStack(spacing: 5) {
                DailyStreak(streak: model.dailyStreak)
                
                Button(action: {
                    model.gameType = .Daily
                    begin()
                }) {
                    DailyMain(completed: model.$completedDaily)
                        .overlay(ButtonShimmer(inView: inView))
                        .fixedSize()
                }
                .buttonStyle(AdvancedButtonStyle())
            }
            
            HStack(spacing: 12) {
                Button(action: {
                    model.gameType = .Classic
                    model.level = .easy
                    begin()
                }) {
                    ButtonMain(title: "Classic", colors: [.aqua2,.aqua1])
                        .overlay(ButtonShimmer(inView: inView, delay: 0.2))
                        .fixedSize()
                }
                .buttonStyle(AdvancedButtonStyle())
                
                ButtonStat(num: "\(model.bestClassic)", caption: "BEST", color: .aqua1)
            }
            
            HStack(spacing: 12) {
                ButtonStat(num: "\(model.bestTime)", caption: "BEST", color: .endRed)
                
                Button(action: {
                    model.gameType = .Speed
                    begin()
                }) {
                    ButtonMain(title: "SPEED", colors: [.endRed,.startRed])
                        .overlay(ButtonShimmer(inView: inView, delay: 0.5))
                        .fixedSize()
                }
                .buttonStyle(AdvancedButtonStyle())
            }
            
            HStack(spacing: 12) {
                
                Button(action: {
                    model.gameType = .Multiplayer
                    begin()
                }) {
                    ButtonMain(title: "Multiplayer", colors: [.multi1,.multi2,.multi3], unitPoints: [.bottomLeading, .topTrailing])
                        .overlay(ButtonShimmer(inView: inView, delay: 0.6))
                        .fixedSize()
                }
                .buttonStyle(AdvancedButtonStyle())
                
                ButtonStat(num: "\(model.multiplayerWins)", caption: "WINS", color: .multi3)
            }
        }
    }
    
    func begin() {
        checkIfDictionaryExists()
        system.playSound("bling",0.5)
        model.newGame()
        withAnimation(Animation.default.speed(0.3)) {
            startGame.toggle()
        }
    }
    
    func checkIfDictionaryExists() {
        DispatchQueue.main.async {
            if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: "Swift") {
                return
            }
            
            withAnimation(Animation.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.6)) {
                presentError.toggle()
            }
        }
    }
}

struct ButtonMain: View {
    
    var title: String
    var colors: [Color]
    var unitPoints = [UnitPoint.topLeading, .bottomTrailing]
    
    var body: some View {
        
        HStack {
            
            if title == "SPEED" {
                Spacer()
            }
        
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            if title != "SPEED" {
                Spacer()
            }
        }
        .padding()
        .padding(.horizontal)
        .frame(width: Global.screenWidth * 0.62)
        .modifier(NeumorphicModifier(colors: colors, unitPoints: unitPoints, spread: 2))
    }
}

struct ButtonStat: View {
    var num: String
    var caption: String
    var color: Color
    
    var body: some View {
        
            VStack(spacing: -3) {
                Text(num)
                    .font(.system(size: 20))
                    .fontWeight(.bold).foregroundColor(color)
                
                Text(caption)
                    .font(.system(size: 15))
                    .fontWeight(.semibold).foregroundColor(color)
            }
            .padding(12)
            .modifier(NeumorphicModifier(colors: [Color.white, Color.background], cr: 16, blur: 2, blurOffset: 4))
            .fixedSize(horizontal: true, vertical: true)
        
    }
}

struct adBdge_Previews: PreviewProvider {
    static var previews: some View {
        adBadge()
    }
}
