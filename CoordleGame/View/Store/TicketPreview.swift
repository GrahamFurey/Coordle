//
//  TicketPreview.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/13/22.
//

import SwiftUI

struct TicketPreview: View {
    
    var inView: Bool
    
    var body: some View {
        
        
        HStack(spacing: 10) {
            
            Image("ticket")
                .resizable()
                .scaledToFit()
                .rotationEffect(.init(degrees: 130))
                .opacity(0)
            
            VStack(alignment: .leading) {
                Detail(text: "Remove Ads")
                Detail(text: "Gold Username")
                Detail(text: "Random Mode")
            }
            .fixedSize(horizontal: true, vertical: false)
            
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1.8, dash: [5]))
              .foregroundColor(.white)
              .frame(width: 18.1)
              .overlay(
              
                ZStack {
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .fill(Color.background)
                        .frame(width: 15)
                        .offset(y: -45)
                    
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .fill(Color.background)
                        .frame(width: 15)
                        .rotationEffect(.degrees(180))
                        .offset(y: 45)
                }
              
              )
            
            VStack(alignment: .trailing, spacing: 0) {
                
                Text("Buy Now")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.trailing, 2)
                    .lineLimit(1)
                
                HStack(spacing: 0) {
                    
                    Text("$")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("7.99")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                }
                .fixedSize(horizontal: true, vertical: false)
                
            }
            .padding(.trailing)
            
        }
        .background(
        
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing))
        
        )
        .overlay(
            ButtonShimmer(inView: inView, opacity: 0.6)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
        
            Image("ticket")
                .resizable()
                .scaledToFit()
                .rotationEffect(.init(degrees: 130))
                .shadow(color: Color.black.opacity(0.6), radius: 2, x: 2, y: 2)
            , alignment: .leading
        
        )
        .frame(height: 85)
        .padding(.horizontal)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}

struct Detail: View {
    
    var text: String
    var gold = false
    
    var body: some View {
        HStack(spacing: 2) {
        
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 18, weight: .bold))
                .foreground(
                
                    LinearGradient(gradient: Gradient(colors: [Color.gold2, Color.gold1]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                )
                .background(
                
                    ZStack {
                    
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 18, weight: .bold))
                            .shadow(color: Color.black.opacity(0.6), radius: 1, x: 1, y: 1)
                        
                        Circle()
                            .fill(Color.white)
                            .scaleEffect(0.6)
                        
                    }
                
                )
            
            Text(text)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                
        }
    }
}
