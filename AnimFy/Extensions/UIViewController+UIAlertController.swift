//
//  UIViewController+UIAlertController.swift
//  AnimFy, firstly used on On-The-Map project.
//
//  Created by António Bastião on 01.11.20.
//  Copyright © 2020 António Bastião. All rights reserved.
//

import UIKit

extension UIViewController {

    private var messageTextAttributes: [NSAttributedString.Key: Any] {
        get {
            [
                .foregroundColor: UIColor.systemBlue,
                .strokeColor: UIColor.systemBlue,
                .font: UIFont(name: "AmericanTypewriter-Bold", size: 20)!,
                .strokeWidth: -1.0
            ]
        }
    }

    private var errorAttribute: [NSAttributedString.Key: Any] {
        get {
            [
                .foregroundColor: UIColor.red,
                .strokeColor: UIColor.red,
                .font: UIFont(name: "Helvetica-Bold", size: 20)!,
                .strokeWidth: -1.0
            ]
        }
    }

    /**
     Convenience function to show UIAlertController in case of errors from API calls or geolocation.
     */
    func showErrorAlert(message: String, callback: @escaping () -> Void = {
    }) {

        let attributedTitle = NSAttributedString(string: "Error!\n",
                attributes: errorAttribute)

        let attributedMessage = NSAttributedString(string: message,
                attributes: messageTextAttributes)

        DispatchQueue.main.async {
            callback()
            let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.setValue(attributedTitle, forKey: "attributedTitle")
            alert.setValue(attributedMessage, forKey: "attributedMessage")
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }


    /**
    Convenience function to show UIAlertController to sign background (internet or access DB) activity.
    */
    func showNetworkActivityAlert() -> UIAlertController {
        let alert = setupAlertController()

        present(alert, animated: true)

        return alert
    }

    private func setupAlertController() -> UIAlertController {
        let message = NSAttributedString(string: "Please wait...",
                attributes: messageTextAttributes)

        let alert = UIAlertController(title: nil, message: "", preferredStyle: .alert)

        alert.setValue(message, forKey: "attributedMessage")
        alert.view.tintColor = UIColor.black

        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.color = UIColor.systemBlue
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        return alert
    }
}