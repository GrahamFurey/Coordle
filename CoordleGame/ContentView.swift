//
//  ContentView.swift
//  CoordleApp
//
//  Created by Graham Furey on 3/29/22.
//

import SwiftUI
import RevenueCat
import GoogleMobileAds
import AppTrackingTransparency

struct ContentView: View {
    
    @State var endAnimation = false
    @State var firstTime = true
    @State var startGame = false
    @StateObject var model = DataModel()
    @StateObject var player = PlayerModel.shared
    @StateObject var system = SystemFunctions()
    
    var tab: Int { system.currentView }
    
    init() {
        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
            
            //add IDFA request window
            
            //add links to bottom of vip
            // check internet connection manager.≥≥≥≥≥≥≥
            
            //change VIP so that doesnt unlock all customizables >> add like "x4 spins per day"
            
        } else {
            ATTrackingManager.requestTrackingAuthorization { status in
                                                            
                GADMobileAds.sharedInstance().start(completionHandler: nil)
            }
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
        
            ZStack {
            
                Color.red
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                SplashScreen(fullEnd: $endAnimation)
                    .offset(y: endAnimation ? -(Global.screenHeight * 1.5) : 0)
                    .environmentObject(system)
                
                Home(enterGame: $startGame)
                    .offset(y: endAnimation ? 0 : Global.screenHeight)
                    .offset(y: tab == 0 ? 0 : -(Global.screenHeight))
//                    .offset(x: selectedTab == 1 ? -(Global.screenHeight * 1.5) : 0)
                    .environmentObject(model)
                    .environmentObject(player)
                    .environmentObject(system)
                
                Store()
                    .opacity(tab == 1 ? 1 : 0)
                    .offset(y: tab == 1 ? 0 : Global.screenHeight)
                    .environmentObject(player)
                    .environmentObject(system)
                
                Leaderboard(selectedTab: $system.currentView)
                    .environmentObject(model)
                    .environmentObject(player)
                    .opacity(tab == 2 ? 1 : 0)
                    .offset(y: tab == 2 ? 0 : Global.screenHeight)
                
                Settings()
                    .opacity(tab == 3 ? 1 : 0)
                    .offset(y: tab == 3 ? 0 : Global.screenHeight)
                    .environmentObject(system)
            
            }
            
            Header(currentTab: $system.currentView, jewels: model.jewels, spin: $system.showSpin, enterGame: $startGame)
                .position(x: Global.screenWidth*0.5, y: Global.screenHeight*0.02)
                .environmentObject(player)
//                .offset(y: -(Global.screenHeight*0.02))
            
        }
        .sheet(isPresented: $system.showVIP) {
            VIPCard(isPresented: $system.showVIP)
                .environmentObject(player)
        }
        
        // REMEMBER TO ADD REWARDED FUNCTION
        .preferredColorScheme(.light)
        .statusBar(hidden: true)
        
        .onAppear {
            configurePurchases()
            openAnimation()
        }
    }
    
    func openAnimation() {
        if firstTime {
            
            firstTime = false
        
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
//            
//                withAnimation(Animation.easeIn(duration: 1.0)) {
//                    hideTab.toggle()
//                
//                }
//            }
            
        }
    }
    
    func configurePurchases() {
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: Global.apiKey,
                            appUserID: nil,
                            observerMode: false,
                            userDefaults: nil,
                            useStoreKit2IfAvailable: true)
        Purchases.shared.delegate = PurchasesDelegateHandler.shared
        Purchases.shared.getOfferings { (offerings, error) in
            player.offerings = offerings
        }
    }
}
