//
//  UIWindow+Extension.swift
//  Coordle
//
//  Created by Graham Furey on 3/27/22.
//

import UIKit

extension UIWindow {
    
    static var key: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
                return nil
            }
        return window
    }
    
}
