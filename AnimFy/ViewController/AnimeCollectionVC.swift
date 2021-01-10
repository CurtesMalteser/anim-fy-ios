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
        AF.request("https://kitsu.io/api/edge/anime?page[limit]=5&page[offset]=0").responseJSON { response in
            print(response)
        }
    }

}
