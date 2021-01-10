//
//  AnimeCollectionVC.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit
import Alamofire

class AnimeCollectionVC: BaseCollectionVC {

    @IBOutlet var animeCollectionView: UICollectionView!

    override func viewDidLoad() {
        animeCollectionView.setEmptyMessage("no animes yet")

        downloadCollection(of: AnimFyAPI.anime)
    }

}
