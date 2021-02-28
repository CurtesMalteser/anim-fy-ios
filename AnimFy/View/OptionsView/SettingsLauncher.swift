//
//  SettingsLauncher.swift
//  AnimFy
//
//  Created by António Bastião on 21.02.21.
//
// source: https://www.youtube.com/watch?v=2kwCfFG5fDA
// source: https://www.youtube.com/watch?v=PNmuTTd5zWc

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDataSource,
        UICollectionViewDelegate,
        UICollectionViewDelegateFlowLayout {

    var viewModel: SettingsViewModel!

    private let blackView = UIView()

    private let _cellHeight: CGFloat = 48
    private var _bottomSafeArea: CGFloat {
        if let window = UIApplication.firstKeyWindow() {
            return window.safeAreaInsets.bottom
        } else {
            return CGFloat(0)
        }
    }

    private var _cv: UICollectionView!

    override init() {
        super.init()
    }

    private func collectionView(_ frameWidth: CGFloat, _ frameHeight: CGFloat) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)

        let height: CGFloat = (CGFloat(viewModel.getRows().count) * _cellHeight) + _bottomSafeArea

        cv.frame = CGRect(x: 0, y: frameHeight, width: frameWidth, height: height)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(UINib(nibName: OptionsCell.identifier, bundle: nil),
                forCellWithReuseIdentifier: OptionsCell.identifier)
        return cv
    }

    func showSettings() {

        if let window = UIApplication.firstKeyWindow() {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissSelector)))
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

    @objc private func handleDismissSelector() {
        handleDismiss(settingRow: nil)
    }

    private func handleDismiss(settingRow: SettingsRow? = nil) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.blackView.alpha = 0
            self._cv.frame = CGRect(x: 0, y: self.blackView.frame.height, width: self._cv.frame.width, height: self._cv.frame.height)
        }, completion: { _ in

            if let setting = settingRow {
                setting.completion?()
            }

        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getRows().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionsCell.identifier, for: indexPath) as! OptionsCell

        cell.label.text = viewModel.getRows()[indexPath.row].label
        cell.icon.image = viewModel.getRows()[indexPath.row].icon

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: _cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = viewModel.getRows()[indexPath.row]
        handleDismiss(settingRow: setting)
    }
}