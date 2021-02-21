//
//  UIApplication+UIWindow.swift
//  AnimFy
//
//  Created by António Bastião on 21.02.21.
//

import UIKit

extension UIApplication {

    class func firstKeyWindow() -> UIWindow? {
        shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows
                .filter({ $0.isKeyWindow }).first
    }
}