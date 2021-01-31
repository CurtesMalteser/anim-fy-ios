//
//  PosterDetailsViewCell.swift
//  AnimFy
//
//  Created by António Bastião on 31.01.21.
//

import UIKit

class PosterDetailsHeaderView: UITableViewHeaderFooterView {

    static let identifier = "PosterDetailsHeader"

    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        poster.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
    }

    
}
