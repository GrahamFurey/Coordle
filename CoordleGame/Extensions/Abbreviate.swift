//
//  Abbreviate.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/29/22.
//

import Foundation

extension Int {
    func abbreviate()->String {
        
        let mill = Double(self)/1000000
        let thou = Double(self)/1000
        
        if mill >= 1 {
            if mill >= 100 {
                return (((mill*10).rounded())/10).removeZeros() + "M"
            } else if mill >= 10 {
                return (((mill*100).rounded())/100).removeZeros() + "M"
            } else {
                return (((mill*1000).rounded())/1000).removeZeros() + "M"
            }
        } else if thou >= 1 {
            if thou >= 100 {
                return (((thou*10).rounded())/10).removeZeros() + "K"
            } else if thou >= 10 {
                return (((thou*100).rounded())/100).removeZeros() + "K"
            }
        }
        
        return "\(self)"
    }
}

extension Double {
    func removeZeros() -> String {
        let tempVar = String(format: "%g", self)
        return tempVar
    }
}
