//
//  CoordleGameApp.swift
//  CoordleGame
//
//  Created by Graham Furey on 3/29/22.
//

import SwiftUI
import Firebase

@main
struct CoordleGameApp: App {
//    @Environment(\.scenePhase) private var scenePhase
//    var ad = OpenAd()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .onChange(of: scenePhase) { phase in
//            if phase == .active {
//                ad.tryToPresentAd()
//            }
//        }
    }
}
