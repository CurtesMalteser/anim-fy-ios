//
//  OptionsCell.swift
//  AnimFy
//
//  Created by António Bastião on 21.02.21.
//

import UIKit

class OptionsCell: UICollectionViewCell {

    static let identifier: String = "OptionsCell"

    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var icon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 17)
    }

    override var isHighlighted: Bool {
        get {
            let highlighted = super.isHighlighted
            backgroundColor = highlighted ? .systemBlue : .white
            label.textColor = highlighted ? .white : .systemBlue
            icon.tintColor = highlighted ? .white : .systemBlue
            return highlighted
        }
        set {
            super.isHighlighted = newValue
        }
    }
}
