//
//  ChooseUsername.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/14/22.
//

import SwiftUI

struct ChooseUsername: View {
    
    @State var helperText = ""
    @State var username: String = ""
    @State var incorrects: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
        
            VStack(alignment: .leading) {
                Text("Choose a")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.textColor)
                
                Text("username")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.textColor)
                
            }
            
            VStack(alignment: .leading, spacing: 5) {
                
                
                Text(helperText)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.redC)
                
                TextField("@player42069", text: $username)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.textColor)
                    .onChange(of: self.username, perform: { val in
                       if val.count > 15 {
                           self.username = String(val.prefix(15))
                           helperText = "Too long!"
                           incorrects += 1
                      }
                    })
                
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: Global.screenWidth / 2, height: 4)
                    .foregroundColor(.black)
            }
            
        }
        .padding()
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .frame(width: Global.screenWidth / 1.7)
        .modifier(Shake(animatableData: incorrects))
        .padding(.horizontal)
    }
}

struct ChooseUsername_Previews: PreviewProvider {
    static var previews: some View {
        ChooseUsername()
    }
}
