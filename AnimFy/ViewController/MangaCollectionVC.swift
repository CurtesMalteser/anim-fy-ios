//
//  MangaCollectionVC.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit

class MangaCollectionVC: BaseCollectionVC, BaseCollectionDelegate {

    @IBOutlet var mangaCollectionView: UICollectionView!

    @IBOutlet weak var mangaFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mangaCollectionView.delegate = self
        mangaCollectionView.dataSource = self

        setCollectionViewCellDimensions(collectionView: mangaCollectionView, flowLayout: mangaFlowLayout)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mangaCollectionView.setEmptyMessage("no mangas yet")
        downloadCollection(of: AnimFyAPI.manga)
    }

    func reloadData() {
        mangaCollectionView.reloadData()
    }
}
