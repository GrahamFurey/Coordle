//
//  Rank&Points.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/24/22.
//

import SwiftUI

struct RankPoints: View {
    
    @EnvironmentObject var model: DataModel
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
          
            HomeStats(rank: model.rank.abbreviate(), points: model.points.abbreviate())
                .frame(maxWidth: Global.screenWidth*0.85, maxHeight: 60)
            
            ShareButton()
                .offset(x: 15, y: 20)
                .onTapGesture {
                    model.shareMyStats()
                } 
        }
        .padding(.horizontal)
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(maxHeight: 100)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct HomeStats: View {
    
    var rank: String
    var points: String
    
    var body: some View {
        
        HStack {
            
            HStack {
                
                Image("rank")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 40)
                
                VStack(alignment: .leading) {
                    
                    Text("Rank")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.lightGray))
                    
                    Text(rank)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                }
                
                Spacer()
                
            }
            .fixedSize(horizontal: true, vertical: false)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal)
            
            Divider()
            
            HStack {
                
                Image("xp")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 40)
                
                VStack(alignment: .leading) {
                    
                    Text("Points")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.lightGray))
                    
                    Text(points)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                }
                
                Spacer()
                
            }
            .fixedSize(horizontal: true, vertical: false)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal)
        }
        .padding(.vertical)
        .padding(.horizontal,5)
        .modifier(NeumorphicModifier(spread: 1))
    }
}

struct ShareButton: View {
    
    var body: some View {
        Image(systemName: "square.and.arrow.up")
            .resizable()
            .scaledToFit()
            .foregroundColor(.white)
            .frame(maxWidth: 15)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(LinearGradient(gradient: Gradient(colors: [.lightPurple1,.darkPurple1]), startPoint: .leading, endPoint: .trailing))
                    .shadow(color: Color.black.opacity(0.5), radius: 2, x: 2, y: 2)
            )
    }
}
