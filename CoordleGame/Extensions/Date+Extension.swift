//
//  Date+Extension.swift
//  CoordleGame
//
//  Created by Graham Furey on 4/4/22.
//

import Foundation

extension Date {
    func short() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: self)
    }
    
    func passedTime(from date: Date) -> String {
        let difference = Calendar.current.dateComponents([.minute, .second], from: date, to: self)
        
        let min = difference.minute ?? 00
        let strMin = String(format: "%02d", min)
        let sec = difference.second ?? 00
        let strSec = String(format: "%02d", sec)
        
        let millisecond = Int(Double(difference.nanosecond ?? 0)/10000000 + 0.5)
        let strMsec = String(format: "%02d", millisecond)
        
        if sec >= 999 {
            return "DONE"
        }else if min >= 1 {
            return "\(strMin):\(strSec):\(strMsec)"
        } else {
            return "\(strSec):\(strMsec)"
        }
        
    }
    
    func tomorrow() -> Date {
        let calendar = Calendar.current
        let today = Date()
        let midnight = calendar.startOfDay(for: today)
        return calendar.date(byAdding: .day, value: 1, to: midnight)!
    }
    
    func firstDay() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.date(from: "20220408")!
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: self)
    }
    
    func in12hours() -> Date {
        return Calendar.current.date(byAdding: .hour, value: 12, to: self)!
    }
}

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        if let x = formatter.date(from: self) {
            return x
        }
         
        return Date()
        
    }
}
