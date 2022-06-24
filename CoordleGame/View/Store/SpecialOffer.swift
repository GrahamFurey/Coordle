//
//  SpecialOffer.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/13/22.
//

import SwiftUI

struct SpecialOffer: View {

    var inView: Bool
    let purple1 = Color(UIColor(red: 227/255, green: 171/255, blue: 254/255, alpha: 1.0))
    let purple2 = Color(UIColor(red: 157/255, green: 71/255, blue: 207/255, alpha: 1.0))
    
    var body: some View {
        
        HStack {
        
            VStack {
            
                Text("Special Offer")
                    .font(.system(size: 22))
                    .fontWeight(.heavy)
                    .foregroundColor(.clear)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 12)
                    .background(
                    
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.clear)
                    
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                
                    HStack(spacing: 0) {
                        Image("gem3D")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 27)
                            .shadow(color: Color(.black).opacity(0.6), radius: 4, x: 2, y: 3)
                        
                        Spacer()
                        
                        Text("3300")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        

                    }
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .background(
                    
                        Capsule()
                            .fill(Color.black.opacity(0.2))
                        
                    )
                    
                    HStack(spacing: 2) {
                        
                        HStack(spacing: 0) {
                            
                            Search(padding: 4, cr: 5, shadow: Color.black.opacity(0.5))
                                .scaledToFit()
                            
                            Spacer()
                            
                            Text("6")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            

                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 10)
                        .background(
                            Capsule()
                                .fill(Color.black.opacity(0.2))
                        )
                        
                        HStack(spacing: 0) {
                            GoBack(padding: 4, cr: 5, shadow: Color.black.opacity(0.5))
                                .scaledToFit()
                            
                            Spacer()
                            
                            Text("4")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            

                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 10)
                        .background(
                        
                            Capsule()
                                .fill(Color.black.opacity(0.2))
                            
                        )
                    }
                    
                    HStack {
                        
                        Spacer()
                    
                        HStack(spacing: 0) {
                            Skip(padding: 4, cr: 5, shadow: Color.black.opacity(0.5))
                                .scaledToFit()
                                .frame(width: Global.screenWidth / 10)
                            
                            Spacer()
                            
                            Text("2")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()

                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 10)
                        .background(
                        
                            Capsule()
                                .fill(Color.black.opacity(0.2))
                            
                        )
                        .frame(width: Global.screenWidth / 4)
                        
                        Spacer()
                        
                    }
                    
                }
                .frame(width: Global.screenWidth / 2.5)
                .padding(.leading, 15)
                
                
            }
            
            Image("3600")
                .resizable()
                .scaledToFit()
                .shadow(color: .black.opacity(0.6), radius: 3, x: 3, y: 3)
                .overlay(
                
                    Text("$9.99")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green)
                                .shadow(color: Color(.black).opacity(0.6), radius: 3, x: 2, y: 3)
                            
                        )
                        .offset(y: 40)
                    
                )
            
        }
        .frame(height: Global.screenHeight / 4.5)
        .background(
        
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.gold3, Color.gold1]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .border(LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold3]), startPoint: .topLeading, endPoint: .bottomTrailing), width: 5)
                .cornerRadius(5)
            
        )
        .overlay(
            ButtonShimmer(inView: inView, center: Global.screenWidth * 1.5, endPointBottom: false)
        )
        .overlay(
        
            Text("Special Offer")
                .font(.system(size: 22))
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding(.vertical, 7)
                .padding(.horizontal, 12)
                .background(
                
                    RoundedRectangle(cornerRadius: 0)
                        .fill(
                        
                            LinearGradient(gradient: Gradient(colors: [Color.gold1, Color.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        
                        )
                        .cornerRadius(10, corners: [.bottomRight, .topRight])
                
                )
                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 2, y: 2)
                .padding(.top, 15)
        
            , alignment: .topLeading
        )
        .padding(.horizontal)
    }
}


struct AdFor50: View {
    var body: some View {
        
        HStack(spacing: 20) {
            
            Image("gem")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .shadow(color: .black.opacity(0.6), radius: 3, x: 3, y: 3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("50")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            
            
            Text("FREE")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(5)
                .background(
                
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .shadow(color: .black.opacity(0.6), radius: 3, x: 3, y: 3)
                
                )
                .overlay(
                
                    Image(systemName: "play.rectangle")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding(2)
                        .background(
                        
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.lightBlue)
                                .shadow(color: .black.opacity(0.6), radius: 3, x: 3, y: 3)
                        
                        )
                        .offset(x: 10, y: 10)
                    , alignment: .bottomTrailing
                
                )
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 15)
        .background(
            
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.lighterBlue,Color.lightBlue]),
                                   startPoint: .bottomTrailing,
                                   endPoint: .topLeading)
                )
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
            
        )
        .padding(.horizontal)
    }
}

