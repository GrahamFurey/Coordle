//
//  RoundPause.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/29/22.
//

import SwiftUI

struct RoundPause: View {
    
    var body: some View {
        Top5View()
    }
}

struct Top5View: View {
    
   var top5: [Rank] = []
    
    var body: some View {
        
        VStack {
            ForEach(top5) { player in
                
                HStack {
                
                    Spacer()
                    
                    RankView(rank: player)
                    
                    Image(systemName: "gear")
                    
                    Spacer()
                    
                }
            }
        }
        .padding(.horizontal)
    }
}

struct RoundPause_Previews: PreviewProvider {
    static var previews: some View {
        RoundPause()
    }
}
