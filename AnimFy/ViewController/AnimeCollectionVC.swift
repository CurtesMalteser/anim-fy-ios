//
//  AnimeCollectionVC.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit
import Alamofire

class AnimeCollectionVC: BaseCollectionVC, BaseCollectionDelegate {

    @IBOutlet var animeCollectionView: UICollectionView!

    @IBOutlet weak var animeFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        animeCollectionView.delegate = self
        animeCollectionView.dataSource = self
        setCollectionViewCellDimensions(collectionView: animeCollectionView, flowLayout: animeFlowLayout)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadCollection(of: AnimFyAPI.anime)
    }

    func reloadData() {
        animeCollectionView.reloadData()
    }
}
