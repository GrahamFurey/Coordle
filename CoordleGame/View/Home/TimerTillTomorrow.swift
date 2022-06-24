//
//  TimerTillTomorrow.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/9/22.
//

import SwiftUI

struct TimerTillTomorrow : View {
    @Binding var disabled: Bool
    @State var today: Date = Date()
    var tomorrow: Date = Date().tomorrow()
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.today = Date()
            checkDiff()
        }
    }
    var font: CGFloat = 22
    
    var body: some View {
        Text(countDownString(from: tomorrow))
            .font(.system(size: font))
            .fontWeight(.semibold)
            .onAppear(perform: {
                _ = self.timer
            })
    }

    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.hour, .minute, .second],
                            from: today,
                            to: tomorrow)
        return String(format: "%02d:%02d:%02d",
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
    
    func checkDiff(){
        if today < tomorrow {
            disabled = true
        } else {
            disabled = false
        }
    }
}
