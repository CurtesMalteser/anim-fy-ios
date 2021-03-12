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

    let settingsLauncher = SettingsLauncher()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBarButton(selector: #selector(setupMangaMenu))

        delegate = self
        mangaCollectionView.delegate = self
        mangaCollectionView.dataSource = self
        dataRepository = (UIApplication.shared.delegate as! AppDelegate).mangaRepository
        dataRepository?.statusDelegate = statusDelegate

        settingsLauncher.viewModel = SettingsViewModel(rows: [

            SettingsRow(label: "Favorites", icon: UIImage.imageUserCount()) {
                self.presentFavoriteLaterVC(repoType: .favorite)
            },

            SettingsRow(label: "Read later", icon: UIImage(systemName: "books.vertical")) {
                self.presentFavoriteLaterVC(repoType: .saveForLater)
            },

            SettingsRow(label: "Cancel", icon: UIImage(systemName: "xmark"), completion: nil)

        ])

    }

    private func presentFavoriteLaterVC(repoType: DataRepositoryType) {
        self.presentViewControllerWithInject(storyboard: storyboard,
                identifier: FavoritesLaterCollectionVC.identifier,
                navigationController: navigationController) { (vc: FavoritesLaterCollectionVC) in

            vc.dataRepository = (UIApplication.shared.delegate as! AppDelegate)
                    .injectStoredDatumRepository(repositoryType: repoType, queryType: dataRepository!.type)

        }
    }

    @objc private func setupMangaMenu() {
        settingsLauncher.showSettings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadCollection()
    }

}
