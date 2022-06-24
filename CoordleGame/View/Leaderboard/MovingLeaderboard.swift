//
//  MovingLeaderboard.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/21/22.
//

import SwiftUI

struct MovingLeaderboard: View {
    
    @EnvironmentObject var system: SystemFunctions
    @State private var isFinalized = false
    var allRanks: [Rank] = [Rank]()
    var playerRank: Rank
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.clear)
                .frame(height: Global.screenHeight / 14)
            VStack(spacing: 3) {
                ForEach(allRanks) { rank in
                    RankView2(rank: rank)
                        .background(Color.white)
                        .scaleEffect(0.9)
                        .id(rank.id)
                }
            }
        }
        .frame(width: Global.screenWidth * 0.8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
        ).overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(LinearGradient(gradient: Gradient(colors: [.gold1,.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    , lineWidth: 5)
        )
        .frame(height: Global.screenHeight / 2.8)
        .overlay(

            Text("Global Leaderboard")
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(.white)
                .padding(12)
                .frame(width: Global.screenWidth * 0.9)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [.gold1,.gold2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: Color.black.opacity(0.6), radius: 3, x: 0, y: 2)
                )
            , alignment: .top
        )
        .overlay(
            RankView2(rank: playerRank)
                .overlay(
                
                    ZStack {
                        Color.white.opacity(isFinalized ? 0 : 0.2)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(LinearGradient(gradient: Gradient(colors: isFinalized ? [.gold2,.gold1] : [Color.clear]),
                                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                                , lineWidth: 4)
                    }
                
                )
            , alignment: .center
        )
        .padding(.horizontal, 40)
        .onAppear {
            withAnimation(Animation.easeInOut.delay(4.0)) {
                isFinalized.toggle()
            }
        }
    }
}

//struct MovingLeaderboard_Previews: PreviewProvider {
//    static var previews: some View {
//        MovingLeaderboard(allRanks: [Rank(rank: 590, username: "xddd", pfp: "gem", countryCode: "US", score: "999"),Rank(rank: 590, username: "xddd", pfp: "gem", countryCode: "US", score: "999"),Rank(rank: 590, username: "xddd", pfp: "gem", countryCode: "US", score: "999"),Rank(rank: 590, username: "xddd", pfp: "gem", countryCode: "US", score: "999"),Rank(rank: 590, username: "xddd", pfp: "gem", countryCode: "US", score: "999"),Rank(rank: 590, username: "xddd", pfp: "gem", countryCode: "US", score: "999"),Rank(rank: 590, username: "xddd", pfp: "gem", countryCode: "US", score: "999"),Rank(rank: 590, username: "xddd", pfp: "gem", countryCode: "US", score: "999"),Rank(rank: 590, username: "xddd", pfp: "gem", countryCode: "US", score: "999")],
//                          playerRank: Rank(rank: 20, username: "bruhh", pfp: "gem", countryCode: "US", score: "500"))
//    }
//}

extension MovingLeaderboard {
    
    func getRandom() {
        
    }
    
//    func scrollThru() {
//
//        var stepsPerInterval = change / 2
//        var intervalChange = 0
//        var rankIndex = 7
//
//        (0..<change).forEach { step in
//            let length = DispatchTimeInterval.milliseconds(1000/(stepsPerInterval))
//            DispatchQueue.main.asyncAfter(deadline: .now() + length) {
//                self.shownRanks.insert(allRanks[rankIndex], at: 0)
//            }
//
//            intervalChange += 1
//            rankIndex += 1
//
//            if intervalChange == stepsPerInterval {
//                intervalChange = 0
//                stepsPerInterval = stepsPerInterval / 2
//            }
//
//        }
//
//    }
    
}
