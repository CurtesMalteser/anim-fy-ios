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

    @IBOutlet weak var favoriteFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            setCollectionViewCellDimensions(collectionView: favoriteCollectionView, flowLayout: favoriteFlowLayout)
        }
    }

    static let identifier: String = "FavoritesLaterCollectionVC"

    var dataRepository: DataRepositoryProtocol?

    var successHandler: (DataRepositoryProtocol) -> Void = { _ in
        /* Intentionally left empty. */
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCloseButton(action: #selector(dismissController))

        delegate = self
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
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

    override func dismissController() {
        navigationController?.dismiss(animated: true) {
            (UIApplication.shared.delegate as! AppDelegate).destroyStoredDatumRepository()
        }
    }

}
