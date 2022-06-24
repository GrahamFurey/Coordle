//
//  SystemFunctions.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/18/22.
//

import SwiftUI
import AVFoundation
import CoreHaptics

class SystemFunctions: ObservableObject {

    @AppStorage("soundOn") var soundOn = true
    @AppStorage("hapticsOn") var hapticsOn = true
    @AppStorage("lastSpin") var lastSpin: Date = Date()
    
    @Published var currentView = 0
    @Published var showVIP = false
    @Published var showSpin = false
    @Published var showRewarded = false
    
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    let softGen = UIImpactFeedbackGenerator(style: .soft)
    var audioPlayer: AVAudioPlayer?

    func playSound(_ sound: String, _ volume: Float = 1.0) {
        if soundOn {
        if let path = Bundle.main.path(forResource: sound, ofType: "mp3") {
            do {
                audioPlayer?.volume = volume
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                print("PLAYINGGGGGG")
            } catch {
                print("failed to play sound")
            }
        }
        }
    }
    
    func stopPlaying() {
        audioPlayer?.stop()
    }
    
    func playHard() {
        if hapticsOn {
            generator.impactOccurred()
        }
    }
    
    func playSucess() {
        if hapticsOn {
            generator.impactOccurred()
        }
    }
    
    func playSpinHaptics(_ index: Int) {
        let id = index >= 5 ? index - 3 : index
        let sequence = Global.spinHaptics[id]
        
        for i in 0..<sequence.count {
            let time = DispatchTimeInterval.milliseconds(sequence[i])
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.softGen.impactOccurred()
            }
        }
    }
    
    func updateSpinTime() {
        let today = Date()
        lastSpin = today.in12hours()
    }
}
