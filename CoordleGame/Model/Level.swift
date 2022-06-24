//
//  Level.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/8/22.
//

import Foundation

enum Level: Int, CaseIterable {
    case easy
    case normal
    case hard
    case extreme
    case random
    
    func index() -> Int {
        switch self {
        case .easy:
            return 0
        case .normal:
            return 1
        case .hard:
            return 2
        case .extreme:
            return 3
        case .random:
            return 4
        }
    }
    
    func count() -> Int {
        switch self {
        case .easy:
            return 4
        case .normal:
            return 5
        case .hard:
            return 6
        case .extreme:
            return 7
        case .random:
            return 7
        }
    }
    
    func statSaveKey() -> String {
        switch self {
        case .easy:
            return "easyStatSave"
        case .normal:
            return "normalStatSave"
        case .hard:
            return "hardStatSave"
        case .extreme:
            return "extremeStatSave"
        case .random:
            return "randomStatSave"
        }
    }
    
    func boardSaveKey() -> String {
        switch self {
        case .easy:
            return "easyBoardSave"
        case .normal:
            return "normalBoardSave"
        case .hard:
            return "hardBoardSave"
        case .extreme:
            return "extremeBoardSave"
        case .random:
            return "randomBoardSave"
        }
    }
}

