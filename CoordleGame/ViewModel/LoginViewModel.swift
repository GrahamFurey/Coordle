//
//  LoginViewModel.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/14/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var introStage = 0
    @Published var username = ""
    @Published var favoriteColor = ""
    @Published var favoriteEmoji = ""
    @Published var chosenPFP = ""
    @Published var phoneNumber = ""
    
    func getCountryCode() -> String {
        
        let regionCode = Locale.current.regionCode ?? "US"
        
        return Global.smsCodes[regionCode] ?? "1"
        
    }
    
    func keyAction(val: String){
        
        if val == "delete.left.fill" && phoneNumber != "" {
            phoneNumber.removeLast()
        }
        
        if val != "delete.left.fill" {
            phoneNumber.append(val)
        }
        
    }
    
    func setDefault() {
        if introStage == 2 {
            favoriteColor = "Red"
        } else if introStage == 3 {
            favoriteEmoji = "Smile"
        }
    }
    
}
