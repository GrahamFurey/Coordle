//
//  Item.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/25/22.
//

import Foundation
import SwiftUI

struct Item: Identifiable, Equatable {
    var id: Int
    var img: String
    var color: Color
    var mission: String = ""
    var unlocked: Bool = false
}

let emptyItem = Item(id: 45, img: "", color: .gray)

//let storeItems = [Item(title: "Red", img: "grinRed", color: Color.redFace, cost: 100, custom: true),
//                  Item(title: "Normal", img: "grinNormal", color: Color.normalFace, cost: 100, custom: true),
//                  Item(title: "Blue", img: "grinRed", color: Color.redFace, cost: 100, custom: true),
//                  Item(title: "Purple", img: "grinRed", color: Color.redFace, cost: 100, custom: true),
//                  Item(title: "Pink", img: "grinRed", color: Color.redFace, cost: 100, custom: true),
//                  Item(title: "Rainbow", img: "grinRed", color: Color.redFace, cost: 100, custom: true),
//                  Item(title: "Monkey", img: "grinRed", color: Color.redFace, cost: 100, custom: true),
//                  Item(title: "Cat", img: "grinRed", color: Color.redFace, cost: 100, custom: true),

 
let pfpItems = [Item(id: 0, img: "moneyFace", color: Color.money),
                  Item(id: 1, img: "disguisedFace", color: Color.disguised),
                  Item(id: 2, img: "devilFace", color: Color.devil),
                  Item(id: 3, img: "8ballFace", color: Color.ball),
                  Item(id: 4, img: "vomitFace", color: Color.vomit),
                  Item(id: 5, img: "raccoonFace", color: Color.raccoon),
                  Item(id: 6, img: "bearFace", color: Color.bear),
                  Item(id: 7, img: "cowFace", color: Color.cow),
                  Item(id: 8, img: "pigFace", color: Color.pig),
                  Item(id: 9, img: "koalaFace", color: Color.koala),
                  Item(id: 10, img: "mouseFace", color: Color.mouse),
                  Item(id: 11, img: "chickenFace", color: Color.chicken),
                  Item(id: 12, img: "alienFace", color: Color.alien),
                  Item(id: 13, img: "skullFace", color: Color.skull),
                  
                  Item(id: 14, img: "hamsterFace", color: Color.hamster),
                  Item(id: 15, img: "foxFace", color: Color.fox),
                  Item(id: 16, img: "gorillaFace", color: Color.gorilla),
                  Item(id: 17, img: "gorillaFace", color: Color.chick),
                  Item(id: 18, img: "dogFace", color: Color.dog),
                  Item(id: 19, img: "coinFace", color: Color.coin),
                  Item(id: 20, img: "cheeseFace", color: Color.cheese),
                  Item(id: 21, img: "pumpkinFace", color: Color.pumpkin),
                  Item(id: 22, img: "ghostFace", color: Color.ghost),
                  Item(id: 23, img: "robotFace", color: Color.robot),
                  Item(id: 24, img: "drumFace", color: Color.drum),
                  Item(id: 25, img: "partyFace", color: Color.party),
                  
                  Item(id: 26, img: "frogFace", color: Color.frog),
                  Item(id: 27, img: "lionFace", color: Color.lion),
                  Item(id: 28, img: "rabbitFace", color: Color.rabbit),
                  Item(id: 29, img: "deerFace", color: Color.deer),
                  Item(id: 30, img: "pandaFace", color: Color.panda),
                  Item(id: 31, img: "wolfFace", color: Color.wolf),
                  Item(id: 32, img: "iceFace", color: Color.ice),
                  Item(id: 33, img: "avocadoFace", color: Color.avaocado),
                  
                  Item(id: 34, img: "pixelFace", color: Color.pixel),
                  Item(id: 35, img: "santaFace", color: Color.santa),
                  Item(id: 36, img: "cursingFace", color: Color.cursing),
                  Item(id: 37, img: "octopusFace", color: Color.octopus),
                  Item(id: 38, img: "polarbearFace", color: Color.polarbear),
                  Item(id: 39, img: "tigerFace", color: Color.tiger),
                  Item(id: 40, img: "brainFace", color: Color.brain),
                  Item(id: 41, img: "illuminatiFace", color: Color.illuminati),
                  Item(id: 42, img: "fortunecookieFace", color: Color.fortunecookie),
                  Item(id: 43, img: "ogreFace", color: Color.ogre),
                  Item(id: 44, img: "cloudyFace", color: Color.cloudy),
]
