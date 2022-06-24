//
//  OffsetModifier.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/17/22.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    var returnFromStart = true
    @State var startValue: CGFloat = 0
    
    func body(content: Content)->some View {
        content
            .overlay(
            
                GeometryReader{proxy in
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                        .onPreferenceChange(OffsetKey.self) { val in
                            
                            if startValue == 0 {
                                startValue = val
                            }
                            
                            offset = (val - (returnFromStart ? startValue : 0))
                        }
                }
            )
    }
    
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
