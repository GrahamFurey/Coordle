//
//  StoreConstants.swift
//  CoordleGame
//
//  Created by Graham Furey on 5/3/22.
//

import SwiftUI

struct StoreGroupTitle: View {
    
    var title: String
    var current: Int
    var max: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(title)
                .font(.system(size: 35, weight: .bold))
                .foregroundColor(.blackText)
            
            Text("\(current)/" + max)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white.opacity(0.9))
                .padding(.vertical,5)
                .padding(.horizontal,7)
                .background(
                    ZStack {
                        Color.giftGreen2
                        
                        RoundedRectangle(cornerRadius: 6).fill(
                            LinearGradient(gradient: Gradient(colors: [.giftGreen1,.giftGreen2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .opacity(0.8)
                        .padding(.vertical,3)
                        .padding(.horizontal,3)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .modifier(AddShadow(cr: 8, color: .darkShadow, offsetX: -2, offsetY: 2))
            
            Spacer()
        }
    }
}

struct StoreGroupInfo: View {
    
    var caption: String
    
    var body: some View {
        HStack {
            HStack(spacing: 3) {
            Image(systemName: "info.circle.fill")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(.white.opacity(0.9))
                .padding(.vertical,9)
                .padding(.horizontal,9)
                .background(Color.giftBlue1.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(caption)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.white.opacity(0.9))
                .padding(.vertical, 9)
                .padding(.horizontal, 8)
                .background(Color.blackText.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
            
            Spacer()
        }
    }
}

struct SelectionBox: View {
    var cr: CGFloat = 8
    var gOpacity: CGFloat = 0.8
    var body: some View {
        ZStack {
            Color.background
            
            RoundedRectangle(cornerRadius: cr*0.75)
            .fill(LinearGradient(gradient: Gradient(colors: [Color.background,Color.white]), startPoint: .bottomTrailing, endPoint: .topLeading))
            .opacity(gOpacity)
            .padding(.vertical,3)
            .padding(.horizontal,3)
        }
        .clipShape(RoundedRectangle(cornerRadius: cr))
        .modifier(AddShadow(cr: cr*0.9, color: .darkShadow, offsetX: -4, offsetY: 4))
    }
}

struct SelectionOutline: View {
    var cr: CGFloat = 10
    var w: CGFloat
    var h: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(gradient: Gradient(colors: [Color.white,Color.background]),
                           startPoint: .bottomLeading, endPoint: .topTrailing)
                .frame(height: h*0.22)
                .opacity(0.8)
                .shadow(color: Color.black.opacity(0.4), radius: 1, x: 0, y: -2)
            
            RoundedRectangle(cornerRadius: cr)
            .stroke(LinearGradient(gradient: Gradient(colors: [Color.white,Color.background]),
                                   startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 6)
        }
        .clipShape(RoundedRectangle(cornerRadius: cr))
        .frame(width: w, height: h)
        .modifier(AddShadow(cr: cr*0.9, color: .darkShadow, offsetX: -4, offsetY: 4))
    }
}

struct UseButton: View {
    var text: String = "USE"
    var color1 = Color.giftGreen1
    var color2 = Color.giftGreen2
    var width: CGFloat
    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(.white.opacity(0.9))
            .padding(.vertical,5)
            .padding(.horizontal,7)
            .frame(width: width)
            .modifier(StoreButtonMod(color1: color1, color2: color2, width: width))
            .modifier(AddShadow(cr: 8, color: .darkShadow, offsetX: -2, offsetY: 2))
    }
}

struct LockButton: View {
    var width: CGFloat
    var body: some View {
        Image(systemName: "lock.fill")
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(.white.opacity(0.9))
            .padding(.vertical,5)
            .padding(.horizontal,7)
            .frame(width: width)
            .modifier(StoreButtonMod(color1: .gray, color2: Color(UIColor.lightGray), width: width))
            .modifier(AddShadow(cr: 8, color: .darkShadow, offsetX: -2, offsetY: 2))
    }
}

struct StoreButtonMod: ViewModifier {
    
    var color1: Color
    var color2: Color
    var width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    color2
                    
                    RoundedRectangle(cornerRadius: 6).fill(
                        LinearGradient(gradient: Gradient(colors: [color1,color2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .opacity(0.8)
                    .padding(.vertical,3)
                    .padding(.horizontal,3)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
