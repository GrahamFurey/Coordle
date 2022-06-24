//
//  RankView.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/21/22.
//

import SwiftUI

struct RankView: View {
    
    var rank: Rank
    
    var body: some View {
        HStack(spacing: 15) {
            
            Text("\(rank.rank)")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color.gray)
            
            
            Image(rank.pfp)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .rotationEffect(.degrees(90))
                .padding(8)
                .background( Color.orangeC )
                .frame(width: 55, height: 55)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: Color.gray, radius: 1, x: 2, y: 2)

            Text(rank.username)
                .font(.system(size: 16, weight: .bold))
                .fixedSize(horizontal: true, vertical: false)
            
            Spacer().overlay(
                    
            Text(rank.score.abbreviate() + " XP")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
                .padding(8)
                .background(
                
                    Capsule()
                        .stroke(Color.gray, lineWidth: 1)
                
                )
                .fixedSize(horizontal: true, vertical: false)
            
            , alignment: .trailing)
                
        }
    }
}

struct PlayerRankView: View {
    
    var rank: Rank
    var seondaryColor: Color = .gray
    var usernmcolor: Color = .blackText
    
    var body: some View {
        HStack(spacing: 11) {
            
            Text(String(rank.rank))
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(seondaryColor)
            
            Image(rank.badge)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading,6)
            
            Image(rank.pfp)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.trailing,6)

            Text(rank.username)
                .font(.system(size: rank.username.getFontSize(), weight: .bold))
                .foregroundColor(usernmcolor)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.trailing,6)
            
            
            Spacer().overlay(
                    
            Text(rank.score.bruh() + " XP")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(seondaryColor)
                .padding(8)
                .background(
                
                    Capsule()
                        .stroke(seondaryColor, lineWidth: 1)
                
                )
            
            , alignment: .trailing)
                
        }
        .frame(height: 50)
    }
    
    func getRotation()->Double {
        let prefixs = ["angry","blush","cold","grin","ignore","kiss","sad","scream","squint","wink"]
        
        for i in prefixs {
            if rank.pfp.starts(with: i) {
                return 90.0
            }
        }
        
        return 0
    }
}

extension Int {
    func bruh()->String{
        if self != 900 {
            let x = Double(self)
            return "\(((x/100).rounded())/10)K"
        }
        
        return String(self)
    }
}

struct RankView2: View {
    
    var rank: Rank
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            Text("#\(String(rank.rank))")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .fixedSize()
            
            HStack(spacing: rank.username.getFontSize() / 2) {
                Image("angryBlue")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .rotationEffect(.degrees(90))
                    .padding(4)
                    .background(
                        Color.lightBlue
                    )
                    .frame(width: 35, height: 35)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .overlay(
                    
                        Image("US")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 15, height: 15)
                            .offset(x: 5, y: 5)
                        , alignment: .bottomTrailing
                    )
                    .shadow(color: Color.black.opacity(0.6), radius: 1, x: 2, y: 2)
                
                Text(rank.username)
                    .font(.system(size: rank.username.getFontSize(), weight: .semibold))
                    .lineLimit(1)
                    .foregroundColor(.white)
            }
            
            Spacer().overlay(
            
                HStack(spacing: 5) {
                    Text(rank.score.abbreviate())
                        .font(.system(size: 18, weight: .bold))
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .fixedSize()
                    
                    Image("xp")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .scaleEffect(1.05)
                        )
                }.padding(.trailing,5)
                , alignment: .trailing
            )
        }
        .padding(.horizontal, 3)
        .padding(.vertical, 7)
        .background(
        
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color.clear, location: 0),
                                                                    Gradient.Stop(color: Color.lightPurple1, location: getWidth()),
                                                                    Gradient.Stop(color: Color.darkPurple1, location: 1.0)]), startPoint: .leading, endPoint: .trailing))
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.darkPurple1,.lightPurple1]), startPoint: .leading, endPoint: .trailing))
//
                RoundedRectangle(cornerRadius: 5)
                    .fill(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color.darkPurple2, location: 0),
                                                                    Gradient.Stop(color: Color.darkPurple2, location: getWidth()),
                                                                    Gradient.Stop(color: Color.clear, location: getWidth())]), startPoint: .leading, endPoint: .trailing))
                RoundedRectangle(cornerRadius: 5)
                    .stroke(LinearGradient(gradient: Gradient(colors: [.darkPurple2,.darkPurple1]), startPoint: .leading, endPoint: .trailing), lineWidth: 4)
                
            }
        
        )
        .frame(width: Global.screenWidth * 0.8)
    }
    
    func getWidth() -> Double {
        if rank.rank >= 1000 {
            return 0.23
        } else if rank.rank >= 100 {
            return 0.19
        } else if rank.rank >= 10 {
            return 0.15
        } else {
            return 0.11
        }
    }
    
    
}


extension String {
    func getFontSize()->CGFloat {
        var x = 12
        
        let count = self.count
        if count < 14 {
            x += (14 - count)
        }
        
        return CGFloat(min(x,20))
    }
}

