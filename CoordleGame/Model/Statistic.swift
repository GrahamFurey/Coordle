//
//  Statistic.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/6/22.
//

import Foundation

struct Statistic: Codable {

    var games = 0
    var streak = 0
    var maxStreak = 0
    let key: String
    var frequencies: [Int]
    var wins: Int {
        
        frequencies.reduce(0, +)
        
    }
    
    func saveStats() {
        if let encoded = try? JSONEncoder().encode(self) {
            
            UserDefaults.standard.set(encoded, forKey: self.key)
        }
    }
    
    static func loadStat(key: String, count: Int = 0) -> Statistic {
        
        if let savedStat = UserDefaults.standard.object(forKey: key) as? Data {
            if let currentStat = try? JSONDecoder().decode(Statistic.self, from: savedStat) {
                return currentStat
            } else {
                return Statistic(key: key, frequencies: [Int](repeating: 0, count: count))
            }
        } else {
            return Statistic(key: key, frequencies: [Int](repeating: 0, count: count))
        }
    }
    
    mutating func update(win: Bool, index: Int? = nil) {
        games += 1
        streak = win ? streak + 1 : 0
        if win {
            frequencies[index!] += 1
            maxStreak = max(maxStreak, streak)
        }
        
        saveStats()
    }
    
}
