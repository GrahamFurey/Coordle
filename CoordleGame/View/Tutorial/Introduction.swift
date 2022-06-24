//
//  Introduction.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/14/22.
//

import SwiftUI

struct Introduction: View {
    
    @EnvironmentObject var data: LoginViewModel
    
    var body: some View {
        
        HStack {
        
            FavoriteColor()
                .modifier(IntroPanel(stage: $data.introStage, isComplete: data.username != "", skipAction: data.setDefault))
            
            FavoriteColor()
                .modifier(IntroPanel(stage: $data.introStage, isComplete: data.username != "", skipAction: data.setDefault))
            
            FavoriteColor()
                .modifier(IntroPanel(stage: $data.introStage, isComplete: data.username != "", skipAction: data.setDefault))
            
            FavoriteColor()
                .modifier(IntroPanel(stage: $data.introStage, isComplete: data.username != "", skipAction: data.setDefault))
            
            
        }
        
    }
}

struct IntroPanel: ViewModifier {
    
    @Binding var stage: Int
    var isComplete: Bool
    var skipAction: () -> Void
    
    func body(content: Content) -> some View {
        
        VStack {
            
            HStack {
                
                if stage >= 2 {
                    HStack(spacing: 0) {
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Text("Back")
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .onTapGesture {
                        stage -= 1
                    }
                    
                }
                
                Spacer()
            }
            
        
            content
            
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    stage += 1
                }) {
                    Text("Continue")
                        .font(.system(size: 15, weight: .semibold))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green)
                        )
                        .opacity(isComplete ? 1 : 0)
                        .disabled(isComplete)
                }
                
                
                
                Spacer().overlay(
                    
                    Group {
                        if stage >= 2 {
                            
                            HStack {
                                
                                Text("Skip")
                                    .font(.system(size: 15, weight: .semibold))
                                
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            .onTapGesture {
                                skipAction()
                                stage += 1
                            }
                            
                        }
                    }
                )
                
            }
            
        }
    }
}

struct Introduction_Previews: PreviewProvider {
    static var previews: some View {
        Introduction()
    }
}
