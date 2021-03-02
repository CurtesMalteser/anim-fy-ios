//
//  UserOptionsViewCell.swift
//  AnimFy
//
//  Created by António Bastião on 28.02.21.
//

import UIKit

class UserOptionsViewCell: UITableViewCell {

    public static let identifier = "UserOptionsViewCell"

    var toggleFavorite: () -> Void = {
    }
    var toggleForLater: () -> Void = {
    }


    @IBAction func likeButtonPressed(_ sender: Any) {
        toggleFavorite()
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        toggleForLater()
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
