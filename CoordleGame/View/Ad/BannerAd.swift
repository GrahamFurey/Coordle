////
////  BannerAd.swift
////  CoordleGame
////
////  Created by Graham Furey on 3/30/22.
////
//
//import SwiftUI
//import GoogleMobileAds
//import UIKit
//
//public struct SwiftUIBannerAd: View {
//    @State var height: CGFloat = 0
//    @State var width: CGFloat = 0
//
//    public var body: some View {
//
//        BannerAd()
//            .frame(width: width, alignment: .center)
//            .frame(maxHeight: width/6.4)
//            .onAppear {
//                setFrame()
//            }
//    }
//
//    func setFrame() {
//        let safeAreaInsets = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero
//        let frame = UIScreen.main.bounds.inset(by: safeAreaInsets)
//
//        let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(frame.width)
//
//        self.width = adSize.size.width
//        self.height = adSize.size.height
//    }
//}
//
//class BannerAdVC: UIViewController {
//    let adUnitId: String
//
//    init(adUnitId: String) {
//        self.adUnitId = adUnitId
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var bannerView: GADBannerView = GADBannerView()
//
//    override func viewDidLoad() {
//        bannerView.adUnitID = adUnitId
//        bannerView.rootViewController = self
//        view.addSubview(bannerView)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        loadBannerAd()
//    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate { _ in
//            self.bannerView.isHidden = true //So banner doesn't disappear in middle of animation
//        } completion: { _ in
//            self.bannerView.isHidden = false
//            self.loadBannerAd()
//        }
//    }
//
//    func loadBannerAd() {
//        let frame = view.frame.inset(by: view.safeAreaInsets)
//        let viewWidth = frame.size.width
//
//        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
//
//        bannerView.load(GADRequest())
//    }
//}
//
//final class BannerAd: UIViewControllerRepresentable {
//    let adUnitId: String = "ca-app-pub-3940256099942544/2934735716"
//
//    func makeUIViewController(context: Context) -> BannerAdVC {
//        return BannerAdVC(adUnitId: adUnitId)
//    }
//
//    func updateUIViewController(_ uiViewController: BannerAdVC, context: Context) {
//
//    }
//}
