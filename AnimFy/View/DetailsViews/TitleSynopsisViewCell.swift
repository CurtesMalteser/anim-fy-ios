//
//  TitleSynopsisViewCell.swift
//  AnimFy
//
//  Created by António Bastião on 13.02.21.
//

import UIKit

class TitleSynopsisViewCell: UITableViewCell {

    static let identifier: String = "TitleSynopsisViewCell"

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var synopsis: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
