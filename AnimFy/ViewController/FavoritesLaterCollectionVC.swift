//
//  FavoritesLaterVC.swift
//  AnimFy
//
//  Created by António Bastião on 08.03.21.
//

import UIKit

class FavoritesLaterCollectionVC: BaseCollectionVC, BaseCollectionDelegate {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!

    var collectionView: UICollectionView {
        get {
            favoriteCollectionView
        }
    }

    static let identifier: String = "FavoritesLaterCollectionVC"

    var dataRepository: DataRepositoryProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCloseButton()

        delegate = self
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        dataRepository = (UIApplication.shared.delegate as! AppDelegate).injectStoredDatumRepository(repositoryType: .favorite)
        dataRepository?.statusDelegate = statusDelegate

    }

    // todo -> implement new logic and dedicated repo
    override func postStatus(_ status: Status) {
        super.postStatus(status)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadCollection()
    }

    deinit {
        (UIApplication.shared.delegate as! AppDelegate).destroyStoredDatumRepository()
    }

}
