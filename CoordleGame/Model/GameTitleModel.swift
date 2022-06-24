//
//  GameTitleModel.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/4/22.
//

import SwiftUI

struct GameTitle {
    var title: String
    var color: Color
}

var classicLevels = [
    GameTitle(title: "Easy", color: Color.green),
    GameTitle(title: "Normal", color: Color.yellowC),
    GameTitle(title: "Hard", color: Color.orangeC),
    GameTitle(title: "Extreme", color: Color.redC),
    GameTitle(title: "Random", color: Color.clear)
]

//
//func classicTitle(lvl: Int) -> GameTitle {
//    return GameTitle(title: "Classic", overlay: "lvl. \(lvl)", color: Color.white, color2: Color.black, offsetX: 12, offsetY: 15)
//}
//
//func dailyTitle(date: String) -> GameTitle {
//    return GameTitle(title: "Daily", overlay: date, color: Color.white, color2: Color.black, offsetX: 12, offsetY: 15)
//}
//
//func multiplayerTitle(rank: String) -> GameTitle {
//    return GameTitle(title: "Multiplayer", overlay: rank, color: Color.white, color2: Color.black, offsetX: 12, offsetY: 15)
//}
//
//func timerTitle(timer: String) -> GameTitle {
//    return GameTitle(title: "Classic", overlay: timer, color: Color.white, color2: Color.black, offsetX: 12, offsetY: 15)
//}
