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

    lazy var successHandler: (DataRepositoryProtocol) -> Void = { repository in

        if (repository.dataList.isEmpty) {
            let datumRepo = (repository as! StoredDatumRepository)

            let queryType = (datumRepo.queryType == DataRepositoryType.anime)
                    ? "Anime"
                    : "Manga"

            let message = (datumRepo.type == DataRepositoryType.favorite)
                    ? """
                      You don't have any items on your favorites list yet!

                      You can find them on your initial \(queryType) page.
                      """
                    : """
                      You didn't save any items for late yet!

                      You can find them on your \(queryType) page.
                      """


            self.favoriteCollectionView.setEmptyMessage(message)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItem()

        delegate = self
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        dataRepository?.statusDelegate = statusDelegate

    }

    private func setupNavigationItem() {

        setUpCloseButton(action: #selector(dismissController))

        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]

        navigationItem.standardAppearance = appearance

        navigationItem.title = (dataRepository as! StoredDatumRepository).viewTitle
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (dataRepository!.dataList.count > 0) {
            downloadMoreCollection()
        } else {
            downloadCollection()
        }
    }

    override func dismissController() {
        navigationController?.dismiss(animated: true) {
            (UIApplication.shared.delegate as! AppDelegate).destroyStoredDatumRepository()
        }
    }

}