//
//  PlayerStats.swift
//  Coordle
//
//  Created by Graham Furey on 3/28/22.
//

import Foundation
import Network
import Combine
import RevenueCat
import SwiftUI
import FirebaseFirestore

//PlayerModel: store user defaults and purchases data
class PlayerModel: ObservableObject {
    
    //singlet reference - self
    static let shared = PlayerModel()
    
    //singlet reference - firestore
    private var database = Firestore.firestore()
    
    @Published var username: String = "Graham"
    @Published var players = [Player]()
    @Published var offerings: Offerings? = nil
    @Published var subscriptionActive: Bool = false
    @Published var customerInfo: CustomerInfo? {
        didSet {
            subscriptionActive = customerInfo?.entitlements[Global.entitlementID]?.isActive == true
        }
    }
    
    @AppStorage("currentPFP") var currentPFP = ""
    @AppStorage("currentFont") var currentFont = 0
    
    //PLAYER DATA
    func fetchPlayerData(_ lobby: String) {
        database.collection(lobby).addSnapshotListener { (query, err) in
            guard let docs = query?.documents else {
                print("DOCUMENTS NIL")
                return
            }
            
            self.players = docs.map { (docQuery) -> Player in
                let data = docQuery.data()
                
                let level = data["level"] as? Int ?? 0
                let rank = data["rank"] as? Int ?? 0
                let username = data["username"] as? String ?? ""
                let pfp = data["pfp"] as? String ?? ""
                let cc = data["cc"] as? String ?? ""
                let score = data["score"] as? Int ?? 0
                
                return Player(level: level, rank: rank, username: username, pfp: pfp, cc: cc, score: score)
            }
        }
    }
    
    //PURCHASES
    func login(userId: String) {
        Purchases.shared.logIn(userId) { _, _, _ in }
    }
    
    func logout() {
        Purchases.shared.logOut(completion: nil)
    }
    
}

//PLAYER (ID,H): user save data
struct Player: Identifiable, Hashable {
    var id = UUID().uuidString
    var level: Int
    var rank: Int
    var username: String
    var pfp: String
    var cc: String
    var score: Int
}

//NetworkMonitor: detects internet connection status
final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = true
    
    //AUTO: init() to queue
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}

//cancellables
private var cancellables = [String:AnyCancellable]()

//Published+Extension (GLOBAL): store UserDefaults in @Published
extension Published {
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { val in
            UserDefaults.standard.set(val, forKey: key)
        }
    }
}

//UserDefaults+Extension (GLOBAL): store RAW Types in UserDefaults
extension UserDefaults {

    func value<T: RawRepresentable>(_ type: T.Type, forKey key: String) -> T? {
        guard let value = value(forKey: key) as? T.RawValue else {
            return nil
        }

        return T(rawValue: value)
    }

    func value<T: RawRepresentable>(_ type: T.Type, forKey key: String, default: T) -> T {
        return value(type, forKey: key) ?? `default`
    }

    func setValue<T: RawRepresentable>(_ value: T, forKey key: String) {
        setValue(value.rawValue, forKey: key)
    }

}
