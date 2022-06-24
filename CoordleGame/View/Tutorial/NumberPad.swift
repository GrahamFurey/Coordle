//
//  NumberPad.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/14/22.
//

import SwiftUI

struct NumberPad: View {
    
    let rows = ["1","2","3","4","5","6","7","8","9","","0","delete.left.fill"]
    @EnvironmentObject var data: LoginViewModel
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                
                ForEach(rows, id: \.self) { row in
                    
                    Button(action: { data.keyAction(val: row) }) {
                        
                        ZStack {
                            
                            if row == "delete.left.fill" {
                                
                                Image(systemName: row)
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.textColor)
                                    .opacity(data.phoneNumber == "" ? 0.5 : 1.0)
                                
                            } else {
                            
                                Text(row)
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.textColor)
                                
                            }
                            
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        
                    }
                    .disabled(row == "" ? true : false)
                }
            }
            .padding()
        }.background(Color(UIColor.lightGray))
    }
}
