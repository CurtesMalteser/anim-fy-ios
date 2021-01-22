//
//  MangaCollectionVC.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit

class MangaCollectionVC: BaseCollectionVC, BaseCollectionDelegate {

    @IBOutlet var mangaCollectionView: UICollectionView!

    @IBOutlet weak var mangaFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            setCollectionViewCellDimensions(collectionView: mangaCollectionView, flowLayout: mangaFlowLayout)
        }
    }


    var dataRepository: DataRepositoryProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        mangaCollectionView.delegate = self
        mangaCollectionView.dataSource = self
        dataRepository = MangaRepository.sharedInstance(statusDelegate: statusDelegate)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadCollection()
    }

    func reloadData() {
        mangaCollectionView.reloadData()
    }
}
