//
//  FavoriteColor.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/14/22.
//

import SwiftUI

struct FavoriteColor: View {
    
    @State var choice = "Red"
    @Namespace var animation
    var colors = ["Red",
                  "Normal",
                  "Green",
                  "Blue",
                  "Purp",
                  "Pink"]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
        
            VStack(alignment: .leading) {
                Text("What's your")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.textColor)
                
                Text("favorite color?")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.textColor)
                
            }
            
            HStack {
            
                ForEach(colors, id: \.self) { color in
                    
                    Button(action: {
                        withAnimation(Animation.interactiveSpring(response: 0.3, dampingFraction: 0.9, blendDuration: 0.4)) {
                            choice = color
                        }
                    }) {
                    
                    Image("blank\(color)")
                        .resizable()
                        .scaledToFit()
                        .background(
                            
                            ZStack {
                                
                                if choice == color {
                                
                                Circle()
                                    .stroke(Color.textColor, lineWidth: 2)
                                    .scaleEffect(1.2)
                                    .matchedGeometryEffect(id: "COLOR", in: animation)
                                    
                                }
                                
                            }
                            
                            )
                    }
                }
                
            }
            .frame(width: Global.screenWidth / 1.5)
            
        }
        .padding()
        .padding(.horizontal, 7)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(20)
    }
}

struct FavoriteColor_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteColor()
    }
}
