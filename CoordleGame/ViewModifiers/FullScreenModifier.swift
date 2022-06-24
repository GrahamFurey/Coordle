//
//  FullScreenModifier.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/3/22.
//

import SwiftUI

struct FullScreenModifier<Parent: View>: View {
    @Binding var isPresented: Bool
    @State var adType: AdType

    enum AdType {
        case interstitial
        case rewarded
    }
    
    var rewardFunc: () -> Void
    var parent: Parent
    
    var body: some View {
        ZStack {
            parent
            
            if isPresented {
                EmptyView()
                    .edgesIgnoringSafeArea(.all)
                
                if adType == .rewarded {
                    RewardedAdController(isPresented: $isPresented, rewardFunc: rewardFunc)
                        .edgesIgnoringSafeArea(.all)
                } else if adType == .interstitial {
                    InterstitialAd(isPresented: $isPresented)
                }
            }
        }
        .onAppear {
            //Initialize the ads as soon as the view appears
            if adType == .rewarded {
                RewardedAdController.Coordinator.shared.loadAd()
            } else if adType == .interstitial {
                InterstitialAd.Coordinator.shared.loadAd()
            }
        }
    }
}

extension View {
    public func presentRewardedAd(isPresented: Binding<Bool>, rewardFunc: @escaping () -> Void) -> some View {
        FullScreenModifier(isPresented: isPresented, adType: .rewarded, rewardFunc: rewardFunc, parent: self)
    }
    
    public func presentInterstitialAd(isPresented: Binding<Bool>) -> some View {
        FullScreenModifier(isPresented: isPresented, adType: .interstitial, rewardFunc: {}, parent: self)
    }
}
