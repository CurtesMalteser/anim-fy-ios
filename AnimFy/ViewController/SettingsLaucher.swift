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

    private var _cv: UICollectionView!

    private var collectionView: (_ frameWidth: CGFloat, _ frameHeight: CGFloat) -> UICollectionView = { w, h in
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.frame = CGRect(x: 0, y: h, width: w, height: 200)
        cv.backgroundColor = .white
        return cv
    }

    override init() {
        super.init()
    }


    func showSettings() {

        if let window = UIApplication.firstKeyWindow() {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blackView.frame = window.frame
            blackView.alpha = 0

            window.addSubview(blackView)

            _cv = collectionView(window.frame.width, window.frame.height)
            window.addSubview(_cv)

            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
                self.blackView.alpha = 1
                let y = window.frame.height - self._cv.frame.height
                self._cv.frame = CGRect(x: 0, y: y, width: self._cv.frame.width, height: self._cv.frame.height)
            }
        }

    }

    @objc private func handleDismiss() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
            self.blackView.alpha = 0
            self._cv.frame = CGRect(x: 0, y: self.blackView.frame.height, width: self._cv.frame.width, height: self._cv.frame.height)
        }
    }

}