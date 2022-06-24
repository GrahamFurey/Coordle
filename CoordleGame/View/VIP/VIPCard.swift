//
//  VIPCard.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/11/22.
//

import SwiftUI

struct VIPCard: View {
    
    
    var center = Global.screenWidth / 2
    @EnvironmentObject var store: PlayerModel
    @Binding var isPresented: Bool
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Color.blackText
            
            VStack(spacing: 0) {
                
                Spacer()
                
                HStack {
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.gray.opacity(0.7))
                        .onTapGesture {
                            isPresented.toggle()
                        }
                    
                    Spacer()
                    
                    Text("Restore")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.gray.opacity(0.7))
                    
                    
                }.padding(.horizontal, 15)
                .padding(.bottom, 20)
                
                HStack(spacing: 4) {
                    
                    
                    Text("Coordle")
                        .font(.system(size: 50))
                        .fontWeight(.semibold)
                        .foreground(
                            LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold2]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                    
                    Text("VIP")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foreground(
                            LinearGradient(gradient: Gradient(colors: [Color.gold2, Color.gold3]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                    
                    
                }
                .shadow(color: .black.opacity(0.6), radius: 3, x: 3, y: 3)
                .padding()
                .overlay(
                    ButtonShimmer(inView: isPresented)
                )
                .padding(.horizontal)
                .frame(maxHeight: 90)
            
                VIPCardAnimation()
                
                
                VStack(spacing: 4) {
                    
                    HStack {
                        
                        checkmark()
                        
                        HStack(spacing: 0) {
                        
                            Text("Remove ")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("ALL")
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
//                              .foregroundColor(color1)
                                .foreground(LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                            Text(" ads")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        
                        checkmark()
                        
                        HStack(spacing: 0) {
                        
                            Text("Earn X2 ")
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
                                .foreground(LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                            Text("on ALL rewards")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        
                        checkmark()
                        
                        HStack(spacing: 0) {
                        
                            Text("Exclusive ")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            GoldShimmer(text: "Golden")
//                                .foreground(LinearGradient(gradient: Gradient(colors: [color1, color3]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                            Text(" username")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        
                        checkmark()
                        
                        HStack(spacing: 0) {
                        
                            Text("Unlock ")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("ALL")
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
//                              .foregroundColor(color1)
                                .foreground(LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                            Text(" customizables")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        
                        checkmark()
                        
                        HStack(spacing: 0) {
                        
                            Text("Unlock ")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("RANDOM")
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
//                              .foregroundColor(color1)
                                .foreground(LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                            Text(" mode")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        
                        checkmark()
                        
                        HStack(spacing: 0) {
                        
                            Text("Host ")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("99+")
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
//                              .foregroundColor(color1)
                                .foreground(LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                            Text(" players")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                    }
                }
                .padding(.leading, 40)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    StartButton()
                }
                .buttonStyle(AdvancedButtonStyle())
                .overlay(
                    ButtonShimmer(inView: isPresented, opacity: 0.7)
                        .frame(width: Global.screenWidth * 0.7)
                )
                
                
                Spacer()
                
                SubscriptionDisclaimer()
                
            }
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct checkmark: View {
    
    var body: some View {
        Image(systemName: "checkmark.seal.fill")
            .font(.system(size: 22, weight: .heavy))
            .foreground(LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold3]), startPoint: .bottomTrailing, endPoint: .topLeading))
            .background(
                Circle()
                    .fill(Color.white)
                    .scaleEffect(0.6)
            )
    }
}

struct StartButton: View {
    var body: some View {
        VStack(spacing: 0) {
        
            HStack {
                
                Spacer()
            
                Text("Start")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .shadow(color: .gray.opacity(0.8), radius: 3, x: 3, y: 3)
                
                Spacer()
                
            }
            
            HStack {
                
                Spacer()
            
                Text("3 days FREE then $7.99")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Spacer()
                
            }
        }
        .background(
        
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color.gold1, location: 0.7), Gradient.Stop(color: Color.gold2, location: 0.7)]), startPoint: .top, endPoint: .bottom))
                .frame(width: Global.screenWidth * 0.7)
                .shadow(color: .blackText, radius: 3, x: 3, y: 3)
        
        )
    }
}

struct SubscriptionDisclaimer: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            Text(Global.disclaimer)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(Color.gray.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 20)
        }.frame(height: Global.screenHeight / 10)
        .overlay(
            Rectangle()
                .fill(Color.blackText)
                .frame(height: Global.screenHeight / 50)
                .blur(radius: 5)
                .offset(y: -10)
            , alignment: .top
        )
        .overlay(
            Rectangle()
                .fill(Color.blackText)
                .frame(height: Global.screenHeight / 50)
                .blur(radius: 3)
                .offset(y: 10)
            , alignment: .bottom
        )
    }
}
