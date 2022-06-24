//
//  GuessModel.swift
//  Coordle
//
//  Created by Graham Furey on 3/27/22.
//

import Foundation
import SwiftUI

struct Guess {
    let index: Int
    var word = "     "
    var bgColors = [Color](repeating: .wrong, count: 5)
    var cardFlipped = [Bool](repeating: false, count: 5)
    var guessLetters: [String] {
        word.map { String($0) }
    }
    
    init(count: Int, index: Int) {
        self.index = index
        
        let words = ["    ","     ","      ","       "]
        
        word = words[count - 4]
        bgColors = [Color](repeating: .wrong, count: count)
        cardFlipped = [Bool](repeating: false, count: count)
    }
    
    init(index: Int, word: String, maxLength: Int) {
        self.index = index
        self.word = word.padding(toLength: maxLength, withPad: " ", startingAt: 0)
    }
    
}
