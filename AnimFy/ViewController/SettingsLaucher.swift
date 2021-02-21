//
//  SettingsLaucher.swift
//  AnimFy
//
//  Created by António Bastião on 21.02.21.
//
// source: https://www.youtube.com/watch?v=2kwCfFG5fDA

import UIKit

class SettingsLauncher: NSObject {

    private let blackView = UIView()

    override init() {
        super.init()
    }


    func showSettings() {
        print("more anime")

        if let window = UIApplication.firstKeyWindow() {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)

            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0

            UIView.animate(withDuration: 0.6) {
                self.blackView.alpha = 1
            }
        }
    }

    @objc private func handleDismiss() {
        UIView.animate(withDuration: 0.4) {
            self.blackView.alpha = 0
        }
    }

}