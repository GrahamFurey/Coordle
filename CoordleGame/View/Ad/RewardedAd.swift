//
//  RewardedAd.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/3/22.
//
import SwiftUI
import GoogleMobileAds

final class RewardedAdController: NSObject, GADFullScreenContentDelegate, UIViewControllerRepresentable {

    let rewardedAd = Coordinator.shared.rewardedAd
    @Binding var isPresented: Bool
    let rewardFunc: (() -> Void)
    
    init(isPresented: Binding<Bool>, rewardFunc: @escaping (() -> Void)) {
        self._isPresented = isPresented
        self.rewardFunc = rewardFunc
        super.init()
        
        rewardedAd?.fullScreenContentDelegate = self
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = UIViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            
            self.showAd(from: view)
        }
        
        return view
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject {
        
        var rewardedAds = ["ca-app-pub-6204164666471292/6050597947","ca-app-pub-6204164666471292/3273476503","ca-app-pub-6204164666471292/5708068153"]
        
        var rewardedAd: GADRewardedAd?
        static let shared = Coordinator()
        private var adReceived = false
        var adIndex = 0
        
        func loadAd() {
            
            if adIndex < 3 {
                let req = GADRequest()
                GADRewardedAd.load(withAdUnitID: rewardedAds[adIndex], request: req) { rewardedAd, err in
                    if let err = err {
                        print("Failed to load ad with error: \(err)")
                        self.adIndex += 1
                        self.loadAd()
                        return
                    }
                    
                    self.rewardedAd = rewardedAd
                    self.adIndex = 0
                }
            
            } else {
                adIndex = 0
                return
            }
        }
    }
    
    func showAd(from root: UIViewController) {
        
        if let ad = rewardedAd {
            ad.present(fromRootViewController: root) {
                self.rewardFunc()
            }
        } else {
            print("Ad not ready")
            self.isPresented.toggle()
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        
        Coordinator.shared.loadAd()
        isPresented.toggle()
    }
    
}
