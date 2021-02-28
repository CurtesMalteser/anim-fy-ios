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
    }

    override var isHighlighted: Bool {
        get {
            let highlighted = super.isHighlighted
            backgroundColor = highlighted ? .systemBlue : .white
            label.textColor = highlighted ? .white : .black
            icon.tintColor = highlighted ? .white : .systemBlue
            return highlighted
        }
        set {
            super.isHighlighted = newValue
        }
    }
}
