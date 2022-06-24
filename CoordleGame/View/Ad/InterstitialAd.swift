//
//  InterstitialAd.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/21/22.
//

import SwiftUI
import GoogleMobileAds

struct Advertisement {
    var floor: Int
    var id: String
}

final class InterstitialAd: NSObject, GADFullScreenContentDelegate, UIViewControllerRepresentable {

    let interstitialAd = Coordinator.shared.interstitialAd
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        super.init()
        
        interstitialAd?.fullScreenContentDelegate = self
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = UIViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            self.showAd(in: view)
        }
        
        return view
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject {
        
        var interstitialAds =  ["ca-app-pub-6204164666471292/9455741479","ca-app-pub-6204164666471292/1768823140","ca-app-pub-6204164666471292/4911057468"]
        
        var interstitialAd: GADInterstitialAd?
        static let shared = Coordinator()
        var adIndex = 0
        
        func loadAd() {
            
            if adIndex < 3 {
                let req = GADRequest()
                GADInterstitialAd.load(withAdUnitID: interstitialAds[adIndex], request: req) { interstitialAd, err in
                    if let err = err {
                        print("Failed to load ad with error: \(err)")
                        print(self.interstitialAds[0])
                        self.adIndex += 1
                        self.loadAd()
                        return
                    }
                    
                    self.interstitialAd = interstitialAd
                }
            } else {
                adIndex = 0
                return
            }
        }
    }
    
    func showAd(in viewController: UIViewController) {
        guard let ad = interstitialAd else {
            print("does not have ad")
            self.isPresented.toggle()
            Coordinator.shared.loadAd()
            return
        }
        
        ad.present(fromRootViewController: viewController)
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        Coordinator.shared.loadAd()
    }
}
