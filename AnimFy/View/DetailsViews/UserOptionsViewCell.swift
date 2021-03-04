//
//  UserOptionsViewCell.swift
//  AnimFy
//
//  Created by António Bastião on 28.02.21.
//

import UIKit

class UserOptionsViewCell: UITableViewCell {

    public static let identifier = "UserOptionsViewCell"

    var favorite: Bool = false {
        didSet {
            if (favorite) {
                likeButton.setImage(UIImage.imageFavorite(), for: .normal)
            } else {
                likeButton.setImage(UIImage.imageNotFavorite(), for: .normal)
            }
        }
    }

    var forLater: Bool = false {
        didSet {
            if (forLater) {
                forLaterButton.setImage(UIImage.imageCheck(), for: .normal)
            } else {
                forLaterButton.setImage(UIImage.imagePlus(), for: .normal)
            }
        }
    }

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

    @IBOutlet weak var likeButton: UIButton!

    @IBOutlet weak var forLaterButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
