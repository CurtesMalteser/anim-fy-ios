//
//  UIImage+ImagePlaceHolder.swift
//  AnimFy, firstly used on Virtual Tourist project.
//
//  Created by António Bastião on 29.12.20.
//

import UIKit

extension UIImage {
    class func imagePlaceholder() -> UIImage? {
        self.init(named: "ImagePlaceholder")
    }

    class func imageUserCount() -> UIImage? {
        self.init(named: "UserCount")
    }

    class func imageFavoritesCount() -> UIImage? {
        self.init(named: "FavoritesCount")
    }
}