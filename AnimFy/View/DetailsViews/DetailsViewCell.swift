//
//  DetailsViewCell.swift
//  AnimFy
//
//  Created by António Bastião on 31.01.21.
//

import UIKit

class DetailsViewCell: UITableViewCell {


    static let identifier = "DetailsViewCell"

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var value: UILabel!

    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
