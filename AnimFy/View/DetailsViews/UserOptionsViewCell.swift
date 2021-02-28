//
//  UserOptionsViewCell.swift
//  AnimFy
//
//  Created by António Bastião on 28.02.21.
//

import UIKit

class UserOptionsViewCell: UITableViewCell {

    public static let identifier = "UserOptionsViewCell"


    @IBAction func likeButtonPressed(_ sender: Any) {
        print("likeButtonPressed")
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        print("addButtonPressed")
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
