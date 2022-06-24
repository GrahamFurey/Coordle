//
//  DataModel.swift
//  Coordle
//
//  Created by Graham Furey on 3/27/22.
//

import Foundation
import SwiftUI
import UIKit

class DataModel: ObservableObject {
    
    let userDefaults: UserDefaults = .standard
    
    @Published var firstTime: Bool = false
    @Published var guesses: [Guess] = []
    @Published var overlayText: String = "GO"
    @Published var overlayColor: Color = Color(UIColor.lightGray)
    @Published var toastText = ""
    
    @Published var currentStat = Statistic(key: "", frequencies: [Int]())
    @Published var totalLetterCount = 5
    
    @Published var scoreboard = [Rank]()
    @Published var currentStreak = 0
    @Published var level: Level = .normal // SET TO lastClassic when classic button is tapped
    @Published var gameType: GameType = .Classic
    @AppStorage("lastLevel") var lastClassicLevel: Level = .hard //CHANGE THIS WHEN ITS CHANGED IN DIFFICULTY PICKER
    @AppStorage("bestClassic") var bestClassic = 35
    @AppStorage("dailyStreak") var dailyStreak = 11
    @AppStorage("multiplayerWins") var multiplayerWins = 6
    @AppStorage("bestTime") var bestTime = 9.9
    @AppStorage("completedDaily") var completedDaily = false
    
    @AppStorage("search") var search = 3
    @AppStorage("goback") var goback = 3
    @AppStorage("laser") var skip = 3
    
    @AppStorage("points") var points = 900
    @AppStorage("rank") var rank = 8192
    @AppStorage("jewels") var jewels = 125
    @AppStorage("scoreIndex") var scoreIndex = 13900
    
    var boardSaves: [BoardSave] = []
    
    let firstDay = Date().firstDay()
    var shake = [Int](repeating: 0, count: 8)
    var boardIndex = 1
    var letterCount = 0
    var keyColors = [String : Color]()
    var matchedLetters = [String]()
    var misplacedLetters = [String]()
    @Published var correctWord = ""
    var currentWord = "test"
    @Published var currentRow = 0
    var inPlay = false
    var gameOver = false
    
    var gamesWithoutAd = 0
    @Published var showInterstitial = false
    
//    var gameStarted: Bool {
//        !currentWord.isEmpty || currentRow > 0
//    }
    
    var disabledKeys: Bool {
        !inPlay || currentWord.count == totalLetterCount
    }
    
    init() {
        for level in Level.allCases {
            boardSaves.append(BoardSave.loadStat(level: level))
        }
        
        verifyWord()
        checkDaily()
        newGame()
    }
    
    func checkDaily() {
//        userDefaults.setValue("", forKey: "dailyDate")
//
        if let dailyDate = userDefaults.string(forKey: "dailyDate") {
            let diff = Calendar.current.dateComponents([.day], from: firstDay, to: dailyDate.toDate())
                if let i = diff.day {
                    if i >= 1 {
                        completedDaily = false
                    }
                }
            }
    }
    
    func newGame() {
        assignDifficulty()
        getWord()
        arrangeBoard()
        currentWord = ""
        inPlay = true
        gameOver = false
        
        getCurrentStat()
    }
    
    func getCurrentStat() {
        switch gameType {
        case .Daily:
            currentStat = Statistic.loadStat(key: "Daily", count: 6)
        case .Classic:
            currentStat = Statistic.loadStat(key: level.statSaveKey(), count: totalLetterCount + 1)
        case .Speed:
            return
        case .Multiplayer:
            return
        }
    }
    
    func assignDifficulty() {
        var x = level.count()
        boardIndex = level.index()
        
        if level == .random {
            if boardSaves[boardIndex].streak == 0 {
                x = Int.random(in: 4...7)
                boardSaves[boardIndex].count = x
            } else {
                x = boardSaves[boardIndex].count
            }
        }
        
        totalLetterCount = x
        shake = [Int](repeating: 0, count: x + 1)
        
    }
    
    func getWord() {
        
        if gameType == .Daily {
            correctWord = dailyWord()
            
        } else {
        
            if totalLetterCount == 4 {
                correctWord = Global.fourLetterWords.randomElement()!
            } else if totalLetterCount == 5 {
                correctWord = Global.fiveLetterWords.randomElement()!
            } else if totalLetterCount == 6 {
                correctWord = Global.sixLetterWords.randomElement()!
            } else if totalLetterCount == 7 {
                correctWord = Global.sevenLetterWords.randomElement()!
            }
        }
    }
    
    
    func arrangeBoard() {
        
        currentRow = 0
        guesses = []
        matchedLetters = []
        misplacedLetters = []
        
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for char in letters {
            keyColors[String(char)] = Color.second
        }
        
        if gameType == .Classic {
            loadGameSave()
        } else {
            for i in 0...totalLetterCount {
                guesses.append(Guess(count: totalLetterCount, index: i))
            }
        }
    }
    
    
    func loadGameSave() {
        let save = boardSaves[boardIndex]
        if boardSaves[boardIndex].correctWord != "" {
            correctWord = save.correctWord
            boardSaves[boardIndex].correctWord = correctWord
        }

        for i in 0...totalLetterCount {
            if save.guesses.indices.contains(i) {
                let word = save.guesses[i]
                if word.map({ String($0) }) != [String](repeating: " ", count: totalLetterCount) {
                    guesses.append(Guess(index: i, word: word, maxLength: totalLetterCount ))
                    setCurrentGuessColors()
                    currentRow += 1
                }
                
            } else {
                guesses.append(Guess(count: totalLetterCount, index: i))
            }
        }
    }
    
    
    func addToCurrentWord(_ letter: String) {
        currentWord += letter
        letterCount += 1
        updateRow()
    }
    
    func enterWord() {
        if currentWord == correctWord {
            endWithWin()
        } else {
        
            if verifyWord() {
                
                setCurrentGuessColors()
                if gameType == .Classic {
                    boardSaves[boardIndex].update(2, currentWord)
                }
                
                if currentRow == totalLetterCount {
                    currentStat.update(win: false)
                    inPlay = false
                    
                    if gameType == .Classic {
                        boardSaves[boardIndex].streak = 0
                        boardSaves[boardIndex].clear()
                    }
                    
                    withAnimation(Animation.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        gameOver = true
                    }
                    
                } else {
                    currentRow += 1
                    letterCount += 1
                    removeAll()
                }
            } else {
                withAnimation {
                    removeAll()
                    shake[currentRow] += 1
                }
            }
        }
    }
    
    func endWithWin() {
        setCurrentGuessColors()
        currentStat.update(win: true, index: currentRow)
        toastText = randomToast()
        
        if gameType == .Classic {
            boardSaves[boardIndex].clear()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.flipBoardReverse()
        }
    }
    
    func randomToast()->String {
        let r = Int.random(in: 0...14)
        return Global.comps[r]
    }
    
    func removeLetter() {
        currentWord.removeLast()
        letterCount -= 1
        self.overlayText = "GO"
        self.overlayColor = Color.white
        updateRow()
    }
    
    func removeAll() {
        currentWord.removeAll()
        letterCount = 0
        overlayText = "GO"
        overlayColor = Color(UIColor.lightGray)
        updateRow()
    }
    
    func updateRow() {
        let guessWord = currentWord.padding(toLength: totalLetterCount, withPad: " ", startingAt: 0)
        guesses[currentRow].word = guessWord
    }
    
    func verifyWord() -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentWord)
    }
    
    func setCurrentGuessColors() {
        let correctLetters = correctWord.map { String($0) }
        var freq = [String : Int]()
        
        for letter in correctLetters {
            freq[letter, default: 0] += 1
        }
        
        for index in 0...totalLetterCount - 1 {
            let correctLetter = correctLetters[index]
            let guessLetter = guesses[currentRow].guessLetters[index]
            if guessLetter == correctLetter {
                guesses[currentRow].bgColors[index] = .correct
                if !matchedLetters.contains(guessLetter) {
                    matchedLetters.append(guessLetter)
                    keyColors[guessLetter] = .correct
                }
                if misplacedLetters.contains(guessLetter) {
                    if let index = misplacedLetters.firstIndex(where: {$0 == guessLetter}) {
                        misplacedLetters.remove(at: index)
                    }
                }
                freq[guessLetter]! -= 1
            }
            
        }
        
        for index in 0...totalLetterCount - 1 {
            let guessLetter = guesses[currentRow].guessLetters[index]
            if correctLetters.contains(guessLetter)
                && guesses[currentRow].bgColors[index] != .correct
                && freq[guessLetter]! > 0 {
                guesses[currentRow].bgColors[index] = .misplaced
                if !misplacedLetters.contains(guessLetter) && !matchedLetters.contains(guessLetter){
                    misplacedLetters.append(guessLetter)
                    keyColors[guessLetter] = .misplaced
                }
                freq[guessLetter]! -= 1
            }
        }
        
        for index in 0...totalLetterCount - 1 {
            let guessLetter = guesses[currentRow].guessLetters[index]
            if keyColors[guessLetter] != .correct
                && keyColors[guessLetter] != .misplaced {
                    keyColors[guessLetter] = .wrong
            }
        }
        flipCards(for: currentRow, isForward: true, delete: false, interval: 0.2)
    }
    
    func flipCards(for row: Int, isForward: Bool, delete: Bool, interval: Double) {
        for col in 0..<totalLetterCount {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(col) * interval) {
                
                var x = col
                if !isForward {
                    x = self.totalLetterCount - (col + 1)
                }
                
                self.guesses[row].cardFlipped[x].toggle()
                
                if delete {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.keyColors[String(self.guesses[row].guessLetters[x])] = Color.white
                        let index = self.guesses[row].word.index(self.guesses[row].word.startIndex, offsetBy: x)
                        self.guesses[row].word.replaceSubrange(index...index, with: " ")
                        self.guesses[row].bgColors[x] = .wrong
                    }
                }
            }
        }
    }
    
    func flipBoardReverse() {
        
        for row in 0...currentRow {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(row) * 0.5) {
            
                var isForward = true
                
                if row % 2 == 0 || row == 0 {
                    isForward = false
                }
                
                self.flipCards(for: self.currentRow - row, isForward: isForward, delete: true, interval: 0.1)
            }
        }
    }
    
    func dailyWord() -> String {
        let diff = Calendar.current.dateComponents([.day], from: firstDay, to: Date())
        if let i = diff.day {
            if Global.dailyWords.indices.contains(i) {
                return Global.dailyWords[i]
            }
        }
        
        return Global.dailyWords.randomElement()!
    }
    
    func revealOneLetter() {
        let i = Int.random(in: 0..<totalLetterCount)
        let map = correctWord.map { String($0) }
        let letter = map[i]
        
        withAnimation(Animation.spring()) {
            keyColors[letter] = .lightBlue
        }
    }
    
    func goBackOneRow() {
        self.currentRow -= 1
        let cr = currentRow
        withAnimation { self.guesses[cr].bgColors = [Color](repeating: .red, count: totalLetterCount) }
        shake[cr] += 1
        flipCards(for: cr, isForward: false, delete: true, interval: 0.13)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.13*Double(totalLetterCount)) {
            withAnimation {
                self.updateRow()
            }
        }
    }
    
    func getChangeRanks() {
        scoreboard = []
        
        for i in (scoreIndex..<scoreIndex + 5).reversed() {
            if allScores.indices.contains(i) {
                print(allScores[i])
                let rank = getRank(i)
                scoreboard.append(rank)
            }
        }
        
        for i in (0...scoreIndex).reversed() {
            if allScores[i] >= points {
                scoreIndex = i
                break
            }
            
            print(allScores[i])
            let rank = getRank(i)
            scoreboard.append(rank)
        }
        
        for i in ((scoreIndex - 5)..<scoreIndex).reversed() {
            if allScores.indices.contains(i) {
                print(allScores[i])
                let rank = getRank(i)
                scoreboard.append(rank)
            }
        }
    }
    
    func getRank(_ i: Int)->Rank {
        return Rank(rank: i + 1, username: allUsers[i], pfp: allPFPs[i], cc: allCCs[i], score: allScores[i])
    }
    
    func getSpinPrize(_ d: Int) {
        switch d {
        case 0:
            jewels += 99
        case 1, 7:
            jewels += 75
        case 2, 6:
            jewels += 50
        case 3, 5:
            jewels += 25
        case 4:
            jewels += 999
        default:
            jewels += 25
        }
    }
    
    func shareMyStats() {
        let result = """
I'm #\(rank) and have \(points) in Coordle!
Check it out: https://apple.co/3MsYh1W
"""
        
        result.share()
    }
    
//        let result = """
//        Coordle 001 \(currentRow < 6 ? "\(currentRow + 1)/6" : "")
//        """
//        //        \(guesses.compactMap{$0.results}.joined(seperator: "\n"))
        

    
}

extension String {
    func share() {
        let activityController = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            UIWindow.key?.rootViewController!
                .present(activityController, animated: true)
        case .pad:
            activityController.popoverPresentationController?.sourceView = UIWindow.key
            activityController.popoverPresentationController?.sourceRect = CGRect(x: Global.screenWidth / 2, y: Global.screenHeight / 2, width: 200, height: 200)
            
            UIWindow.key?.rootViewController!.present(activityController, animated: true)
        
        default:
            break
        }
    }
}

//extension UserDefaults {
//
//    func valueExists(key: String) -> Bool {
//        return object(forKey: key) != nil
//    }
//
//}
