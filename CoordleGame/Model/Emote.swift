//
//  Emote.swift
//  CoordleGame
//
//  Created by Graham Furey on 5/3/22.
//

import Foundation

struct Emote: Identifiable, Hashable {
    var id = UUID().uuidString
    var index: Int
    var name: String
    var scale: Double = 0.0
    var duration: Int
    var offsetBG: Double = 0.0
    var VIP: Bool = false
}

let allEmotes = [[Emote(index: 0, name: "like", duration: 3000),
                  Emote(index: 1, name: "love", duration: 3000),
                  Emote(index: 2, name: "haha", scale: 0.6, duration: 3000),
                  Emote(index: 3, name: "wow", scale: 0.55, duration: 1500, offsetBG: -5),
                  Emote(index: 4, name: "poop", scale: 0.35, duration: 2740, offsetBG: 5)],
                 
                 [Emote(index: 5, name: "confetti", duration: 1820),
                  Emote(index: 6, name: "fire", duration: 1800),
                  Emote(index: 7, name: "cry", duration: 1560),
                  Emote(index: 8, name: "stars", scale: 0.5, duration: 1280, VIP: true),
                  Emote(index: 9, name: "barf", duration: 2760, VIP: true)],
                 
                 [Emote(index: 10, name: "sleepyLike", scale: 0.65, duration: 2510),
                  Emote(index: 11, name: "sleepyCry", duration: 3000),
                  Emote(index: 12, name: "sleepyWow", duration: 2900),
                  Emote(index: 13, name: "sleepyMad", duration: 1890),
                  Emote(index: 14, name: "sleepySleep", duration: 2940)],
                 
                 [Emote(index: 15, name: "cash", duration: 2840),
                  Emote(index: 16, name: "flash", scale: 0.6, duration: 2440),
                  Emote(index: 17, name: "jazz", scale: 0.6, duration: 3240),
                  Emote(index: 18, name: "sick", duration: 2840),
                  Emote(index: 19, name: "zzz", duration: 2840)],
                 
                 [Emote(index: 20, name: "pokeLike", scale: 0.6, duration: 2000),
                  Emote(index: 21, name: "pokeHaha", duration: 2470),
                  Emote(index: 22, name: "pokeWow", duration: 2770),
                  Emote(index: 23, name: "pokeCry", duration: 3960),
                  Emote(index: 24, name: "pokeMad", duration: 4300)],
                 
                 [Emote(index: 25, name: "funnyLike", scale: 0.6, duration: 3040),
                  Emote(index: 26, name: "funnyLove", scale: 0.6, duration: 3040),
                  Emote(index: 27, name: "funnyHaha", duration: 3040),
                  Emote(index: 28, name: "funnyWow", duration: 3000),
                  Emote(index: 29, name: "funnyCry", duration: 2880),
                  Emote(index: 30, name: "funnyMad", duration: 2840)],
                 
                 [Emote(index: 31, name: "spookyLike", scale: 0.6, duration: 2950),
                  Emote(index: 32, name: "spookyLove", scale: 0.6, duration: 2520),
                  Emote(index: 33, name: "spookyHaha", duration: 2520),
                  Emote(index: 34, name: "spookyWow", duration: 2520),
                  Emote(index: 35, name: "spookyCry", duration: 2360),
                  Emote(index: 36, name: "spookyMad", duration: 2480)],

]
