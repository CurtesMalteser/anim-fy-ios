//
//  MangaCollectionVC.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit

class MangaCollectionVC: BaseCollectionVC {

    @IBOutlet var mangaCollectionView: UICollectionView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mangaCollectionView.setEmptyMessage("no mangas yet")
        downloadCollection(of: AnimFyAPI.manga)
    }
}
