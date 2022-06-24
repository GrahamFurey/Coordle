//
//  BoardSave.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/8/22.
//

import Foundation


struct BoardSave: Codable {
    let key: String
    var count: Int
    var streak: Int = 0
    var guesses: [String] = []
    var correctWord: String = ""
    
    func saveStats() {
        if let encoded = try? JSONEncoder().encode(self) {
            
            UserDefaults.standard.set(encoded, forKey: self.key)
        }
    }
    
    static func loadStat(level: Level) -> BoardSave {
        if let savedBoard = UserDefaults.standard.object(forKey: level.boardSaveKey()) as? Data {
            if let currentStat = try? JSONDecoder().decode(BoardSave.self, from: savedBoard) {
                return currentStat
            } else {
                return BoardSave(key: level.boardSaveKey(), count: level.count())
            }
        } else {
            return BoardSave(key: level.boardSaveKey(), count: level.count())
        }
    }
    
    mutating func update(_ points: Int, _ guess: String) {
        streak += points
        guesses.append(guess)
        saveStats()
    }
    
    mutating func clear() {
        guesses = []
        correctWord = ""
        saveStats()
    }
    
    mutating func end() {
        streak = 0
        saveStats()
    }
}
