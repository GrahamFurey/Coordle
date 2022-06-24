//
//  GemStoreButtons.swift
//  CoordleGame
//
//  Created by Graham Furey on 5/5/22.
//

import SwiftUI

struct GemForPrize: View {
    @State var bounce = false
    var w: CGFloat = Global.screenWidth*0.45
    let gg = LinearGradient(gradient: Gradient(colors: [Color.background,Color.white]), startPoint: .bottomLeading, endPoint: .topTrailing)
    
    var body: some View {
        HStack(spacing: 5) {
            
            Spacer()
            
            Image("gem3D")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.vertical,1)
                .padding(.horizontal,2)
                .background(
                    ZStack {
                        jewel().foregroundColor(Color.lighterBlue)
                            .offset(x: 1.4, y: 1)
                        jewel().foregroundColor(.white)
                    })
                .shadow(color: Color.white.opacity(0.3), radius: 1, x: 1, y: 2)
                .overlay(
                    Text("500")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.lightBlue)
                        .padding(1)
                        .padding(.horizontal, 2)
                        .background(
                            ZStack {
                                Color.background
                                
                                gg.clipShape(Capsule())
                                    .padding(1.5)
                            }.clipShape(Capsule())
                                .modifier(AddShadow(cr: 50, color: .darkShadow, offsetX: -1.6, offsetY: 1.6))
                        )
                    , alignment: .bottomTrailing
                )
                .padding(.horizontal,3)
            
            arrow()
                .foregroundColor(.white)
                .padding(.vertical,1)
                .padding(.horizontal,2)
                .background(
                    arrow().foregroundColor(Color.darkShadow)
                        .offset(x: -0.7, y: 1.4)).opacity(0.8)
                .scaleEffect(bounce ? 1.5 : 1.2)
                .offset(x: bounce ? 3 : -5)
                .padding(.top,5)
                .padding(.horizontal,5)
            
            GiftRotate()
                .scaleEffect(1.2)
                .padding(.horizontal,5)
                .padding(.bottom,2)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.vertical,8)
        .padding(.horizontal,15)
        .frame(width: w)
        .background(
            ZStack {
                
                let x = Gradient(colors: [.lightBlue, .giftGreen1])
                let y = Gradient(colors: [.lighterBlue, .giftGreen2])
                
                LinearGradient(gradient: x, startPoint: .bottomLeading, endPoint: .topTrailing)
                    .opacity(bounce ? 0 : 0.7)
                
                LinearGradient(gradient: y, startPoint: .bottomLeading, endPoint: .topTrailing)
                    .opacity(bounce ? 0.7 : 0)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(bounce ? Color.giftGreen1 : Color.lighterBlue, lineWidth: 6)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .modifier(AddShadow(cr: 10, color: .background, offsetX: -2, offsetY: 3))
            .shadow(color: Color.black.opacity(0.3), radius: 1, x: 2, y: -3)
            .frame(height: 45)
            , alignment: .bottom
        ).onAppear {
            withAnimation((Animation.easeInOut(duration: 0.7).delay(0.3)).repeatForever()) {
                bounce.toggle()
            }
        }
    }
    
    @ViewBuilder
    func jewel()->some View {
        Image("gem3D")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    @ViewBuilder
    func arrow()->some View {
        Image("straightArrow")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(1.1)
    }
}

struct GiftRotate: View {
    @State var rotate = 0
    var body: some View {
        ZStack {
            Image("giftCommon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(rotate == 0 ? 1 : 0)
            Image("giftRare")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(rotate == 1 ? 1 : 0)
            Image("giftWrap")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .padding(1.4)
        .background(
            Image("giftCommon")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(Color.lighterBlue)
        )
        .shadow(color: Color.white.opacity(0.3), radius: 1, x: 1, y: 1)
        .onAppear {
            withAnimation((Animation.easeInOut(duration: 0.4).delay(0.7)).repeatForever()) {
                 rotate += 1
            }
        }
    }
}

struct GemStoreButtons_Previews: PreviewProvider {
    static var previews: some View {
        GemForPrize()
    }
}

struct AdForGem: View {
    @State var bounce = false
    var amt: Int = 50
    var w: CGFloat = Global.screenWidth*0.45
    let gg = LinearGradient(gradient: Gradient(colors: [Color.background,Color.white]), startPoint: .bottomLeading, endPoint: .topTrailing)
    
    var body: some View {
        HStack(spacing: 5) {
            
            Spacer()
            
            Image("film")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.vertical,1)
                .padding(.horizontal,2)
                .background(
                    ZStack {
                        film().foregroundColor(Color.gold2)
                            .offset(x: 1.4, y: 1)
                        film().foregroundColor(.white)
                    })
                .shadow(color: Color.white.opacity(0.3), radius: 1, x: 1, y: 2)
            
            arrow()
                .foregroundColor(.white)
                .padding(.vertical,1)
                .padding(.horizontal,2)
                .background(
                    arrow().foregroundColor(Color.darkShadow)
                        .offset(x: -0.7, y: 1.4)).opacity(0.8)
                .scaleEffect(bounce ? 1.5 : 1.2)
                .offset(x: bounce ? 3 : -5)
                .padding(.top,5)
                .padding(.horizontal,5)
            
            Image("gem3D")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.vertical,1)
                .padding(.horizontal,2)
                .background(
                    ZStack {
                        jewel().foregroundColor(Color.gold2)
                            .offset(x: 1.4, y: 1)
                        jewel().foregroundColor(.white)
                    })
                .shadow(color: Color.white.opacity(0.3), radius: 1, x: 1, y: 2)
                .overlay(
                    Text("\(amt)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.gold2)
                        .padding(1)
                        .padding(.horizontal, 2)
                        .background(
                            ZStack {
                                Color.background
                                
                                gg.clipShape(Capsule())
                                    .padding(1.5)
                            }.clipShape(Capsule())
                                .modifier(AddShadow(cr: 50, color: .darkShadow, offsetX: -1.6, offsetY: 1.6))
                        )
                    , alignment: .bottomTrailing
                )
                .padding(.horizontal,3)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.vertical,8)
        .padding(.horizontal,15)
        .frame(width: w)
        .background(
            ZStack {
                
                let x = Gradient(colors: [.gold1, .gold2])
                LinearGradient(gradient: x, startPoint: .bottomLeading, endPoint: .topTrailing)
                    .opacity(0.7)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gold2, lineWidth: 6)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .modifier(AddShadow(cr: 10, color: .background, offsetX: -2, offsetY: 3))
            .shadow(color: Color.black.opacity(0.3), radius: 1, x: 2, y: -3)
            .frame(height: 45)
            , alignment: .bottom
        ).fixedSize()
            .overlay(
                
                ButtonShimmer(inView: true)
            
            )
            .scaleEffect(bounce ? 1.05 : 0.85)
        .onAppear {
            withAnimation((Animation.easeInOut(duration: 0.9)).repeatForever()) {
                bounce.toggle()
            }
        }
    }
    
    @ViewBuilder
    func jewel()->some View {
        Image("gem3D")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    @ViewBuilder
    func film()->some View {
        Image("film")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    @ViewBuilder
    func arrow()->some View {
        Image("straightArrow")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(1.1)
    }
}
