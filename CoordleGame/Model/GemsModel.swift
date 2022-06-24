//
//  GemsModel.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/3/22.
//

import Foundation

struct Gems: Identifiable {
    var id = UUID().uuidString
    let image: String
    let title: String
    let price: String
    let product: Int
}

var gems = [
    Gems(image: "gems1", title: "350", price: "$0.99", product: 1),
    Gems(image: "gems2", title: "1660", price: "$4.99", product: 2),
    Gems(image: "gems3", title: "3600", price: "$9.99", product: 3),
    Gems(image: "gems4", title: "7750", price: "$19.99", product: 4),
    Gems(image: "gems5", title: "21000", price: "$49.99", product: 5),
    Gems(image: "gems6", title: "55000", price: "$99.99", product: 6),
]
