//
//  MangaCollectionVC.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit

class MangaCollectionVC: BaseCollectionVC, BaseCollectionDelegate {

    @IBOutlet var mangaCollectionView: UICollectionView!

    var collectionView: UICollectionView {
        get {
            mangaCollectionView
        }
    }

    @IBOutlet weak var mangaFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            setCollectionViewCellDimensions(collectionView: mangaCollectionView, flowLayout: mangaFlowLayout)
        }
    }

    var dataRepository: DataRepositoryProtocol?

    var successHandler: (DataRepositoryProtocol) -> Void = { dataRepository in
        if (dataRepository.dataList.count < 30) {
            dataRepository.downloadMoreCollection()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBarButton(selector: #selector(setupMangaMenu))

        delegate = self
        mangaCollectionView.delegate = self
        mangaCollectionView.dataSource = self
        dataRepository = (UIApplication.shared.delegate as! AppDelegate).mangaRepository
        dataRepository?.statusDelegate = statusDelegate
    }

    @objc private func setupMangaMenu() {
        print("more manga")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadCollection()
    }

}
