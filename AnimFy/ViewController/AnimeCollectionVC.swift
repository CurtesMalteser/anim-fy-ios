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

    var dataRepository: DataRepositoryProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewCellDimensions(collectionView: animeCollectionView, flowLayout: animeFlowLayout)
        delegate = self
        animeCollectionView.delegate = self
        animeCollectionView.dataSource = self
        dataRepository = AnimeRepository.sharedInstance(statusDelegate: statusDelegate)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadCollection()
    }

    func reloadData() {
        animeCollectionView.reloadData()
    }
}
