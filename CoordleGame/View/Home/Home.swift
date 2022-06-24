//
//  Home.swift
//  Coordle
//
//  Created by Graham Furey on 3/24/22.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var player: PlayerModel
    @EnvironmentObject var main: DataModel
    @EnvironmentObject var system: SystemFunctions
    
    @State var noPrizes = false
    @State var showHelp = false
    @Binding var enterGame: Bool
    @State var showError = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            VStack(spacing: 20) {
                
                HStack(alignment: .bottom) {
                    LetsPlay(username: player.username)
                    Spacer()
                    SpinWheelButton(disabled: $noPrizes, spin: $system.showSpin)
                        .padding(.top,20)
                        .onTapGesture {
                            system.showSpin.toggle()
                        }
                }
                .frame(maxWidth: Global.screenWidth*0.87)
                
                RankPoints()
                    .padding(.vertical, 20)
                
                Buttons(presentError: $showError, startGame: $enterGame)
                
                HStack(spacing: 20) {
                    
                    Button(action: {system.currentView = 1}) {
                        SmallButton()
                    }.buttonStyle(AdvancedButtonStyle())
                    
                    Button(action: {system.currentView = 2}) {
                        SmallButton(img: "chart", color1: .smallButtonPurp2, color2: .smallButtonPurp1, unitpoints: [.bottom,.top], offsetX: -2.5)
                    }.buttonStyle(AdvancedButtonStyle())
                    
                    Button(action: {system.currentView = 3}) {
                        SmallButton(img: "star", color1: .smallButtonYellow2, color2: .smallButtonYellow1, unitpoints: [.bottom,.top], offsetX: 2.5)
                    }.buttonStyle(AdvancedButtonStyle())
                    
                    Button(action: {system.currentView = 3}) {
                        SmallButton(img: "gear", color1: .smallButtonGreen2, color2: .smallButtonGreen1, unitpoints: [.bottomTrailing,.topLeading], offsetX: 5)
                    }.buttonStyle(AdvancedButtonStyle())
                    
                }
                .padding(.top)
                
            }
            .padding(.top,20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .edgesIgnoringSafeArea(.all)
            
            HStack {
                
                Image("CoordleAppIcon")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                
                Button(action: { showHelp.toggle() }) {
                Image(systemName: "questionmark")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.white)
                    .padding(6)
                    .padding(.horizontal,4)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.lighterBlue,.lightBlue]),
                                               startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 2, y: 2)
                        )
                    
                    
                }
                .buttonStyle(AdvancedButtonStyle())
                
            }.frame(width: Global.screenWidth * 0.85)
            .frame(maxHeight: 50)
            
            DictionaryHandler(isPresented: $showError)
            
//            FortuneWheel(disabled: $noPrizes, inView: spin)
//                .offset(x: spin ? 0 : Global.screenWidth)
            
            GameView(isShowing: $enterGame)
                .offset(x: enterGame ? 0 : Global.screenWidth)
            
        }
        .sheet(isPresented: $showHelp) {
            Tutorial(isPresented: $showHelp)
        }
        
    }
}

struct LetsPlay: View {
    var username: String
    
    var body: some View {
        
        HStack {
    
            VStack(alignment: .leading, spacing: 3) {
                
                HStack() {
                    Text("Hey \(username)")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.lightGray))
                    Image("wave")
                        .resizable()
                        .scaledToFit()
                        
                }.frame(maxHeight: 20)
                
            Text("Let's Play")
                .font(.system(size: 45))
                .fontWeight(.bold)
                .foregroundColor(.textColor)
            
        }
            
            Spacer()
    
        }
        
    }
}
