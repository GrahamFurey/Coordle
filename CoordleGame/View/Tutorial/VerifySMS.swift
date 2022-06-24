//
//  VerifySMS.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/14/22.
//

import SwiftUI

struct VerifySMS: View {
    var body: some View {
        
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Would you like to")
                        .font(.system(size: 25, weight: .bold))
                    Text("add your phone #?")
                        .font(.system(size: 25, weight: .bold))
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Connect your phone number to save")
                        .font(.system(size: 15, weight: .regular))
                    
                    HStack(spacing: 0) {
                        
                        Text("your ")
                            .font(.system(size: 15, weight: .regular))
                        
                        Text("high score, points,")
                            .font(.system(size: 15, weight: .bold))
                        
                        Text(" and ")
                            .font(.system(size: 15, weight: .regular))
                        
                        Text("rank.")
                            .font(.system(size: 15, weight: .semibold))
                        
                    }
                    
                }
            }
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    Text("Country Code")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color(UIColor.lightGray))
                    
                    HStack {
                    
                        Text("+1")
                            .font(.system(size: 12, weight: .semibold))
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12, weight: .regular))
                        
                    }
                    .padding(8)
                    .padding(.horizontal, 5)
                    .background(
                        
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.blue, lineWidth: 2)
                        
                    )
                }
                
                
            }
        
        }
    }
}

struct VerifySMS_Previews: PreviewProvider {
    static var previews: some View {
        VerifySMS()
    }
}
